import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:sharkship/features/auth/presentation/state/auth_notifier.dart';
import 'package:sharkship/features/kyc/presentation/screens/digi_locker_screen.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_notifier.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_state.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'package:sharkship/shared/widgets/kyc_dialogs.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'
    hide ImageSource; // Import here

class KycScreen extends ConsumerWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(kycProvider);

    ref.listen<AsyncValue<KycState>>(kycProvider, (prev, next) {
      next.whenOrNull(
        error: (err, _) {
          final prevErr = prev?.asError?.error;
          if (err != prevErr) {
            showDialog(
              context: context,
              builder: (ctx) => ErrorDialog(
                message: err.toString(),
                onRetry: () => Navigator.pop(ctx),
              ),
            );
          }
        },
        data: (s) {
          if (s.shouldNavigateHome) {
            context.go(Routes.HOME);
            return;
          }
          if (s.kyc.status == 'RESOLVED' && s.kyc.agreementAccepted) {
            context.go(Routes.HOME);
          }
          if (s.kyc.status == 'APPROVED') {
            context.go(Routes.HOME);
          }
        },
      );
    });

    return asyncState.when(
      loading: () => const Scaffold(body: Center(child: ThreeDotsLoader())),
      error: (err, _) => Scaffold(
        appBar: AppBar(backgroundColor: AppColors.scaffoldBg, elevation: 0),
        backgroundColor: AppColors.scaffoldBg,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(err.toString()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(kycProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (state) {
        // Guard: if KYC is already resolved/approved, return a blank loading
        // scaffold immediately so ref.listen's navigation fires without the
        // user ever seeing a flash of the KYC screen.
        final shouldRedirect =
            state.shouldNavigateHome ||
            (state.kyc.status == 'RESOLVED' && state.kyc.agreementAccepted) ||
            state.kyc.status == 'APPROVED';

        if (shouldRedirect) {
          return const Scaffold(body: Center(child: ThreeDotsLoader()));
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBg,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Posthog().capture(
                    eventName: 'kyc_log_out',
                    properties: {'kycStep': state.currentStep},
                  );
                  ref.read(authProvider.notifier).logout(() {
                    appRouter.go(Routes.SPLASH);
                  });
                },
                icon: const Icon(Icons.logout, color: Colors.black),
              ),
            ],
          ),
          backgroundColor: AppColors.scaffoldBg,
          body: SafeArea(
            child: Column(
              children: [
                Center(child: _KycStepper(currentStep: state.currentStep)),
                Expanded(
                  child: _buildStepContent(
                    state.currentStep,
                    context,
                    state,
                    ref,
                  ),
                ),
                const _BottomActionButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepContent(
    KycStep step,
    BuildContext context,
    KycState state,
    WidgetRef ref,
  ) {
    switch (step) {
      case KycStep.aadhaar:
        return _aadhaarStep(context, state, ref);
      case KycStep.pan:
        return _panStep(context, state);
      case KycStep.bank:
        return _bankStep(context, state);
      case KycStep.gst:
        return _gstStep(context, state);
      case KycStep.review:
        return _reviewStep(context, state);
      case KycStep.terms:
        return _termsStep(context, state);
      case KycStep.submitted:
        return _submittedStep(context, state, ref);
    }
  }

  Widget _aadhaarStep(BuildContext context, KycState state, WidgetRef ref) {
    void showAadhaarSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ProviderScope(child: const _AadhaarUploadSheet()),
      );
    }

    Future<void> startDigilocker() async {
      final notifier = ref.read(kycProvider.notifier);
      final initRes = await notifier.startDigilockerKyc();

      if (initRes != null && context.mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DigiLockerScreen(
              digilockerUrl: initRes.url,
              verificationId: initRes.verificationId,
              onSuccess: (id) => notifier.completeDigilockerKyc(id),
              onFailure: notifier.handleDigilockerFailure,
              onCancel: () {},
            ),
          ),
        );
      }
    }

    final showReUpload = state.kyc.aadhaar?.isRejected;
    final showCard =
        state.kyc.aadhaar?.aadharName != null &&
        state.kyc.aadhaar?.aadharNumber != null &&
        state.kyc.aadhaar?.aadharProfileImage != null &&
        (showReUpload == null || showReUpload == false);

    final showImages =
        !showCard &&
        (state.kyc.aadhaar?.frontImage != null &&
            state.kyc.aadhaar?.backImage != null) &&
        (showReUpload == null || showReUpload == false);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (showReUpload != null && showReUpload == true) ...[
            AdminRemarksCard(message: "Please verify your aadhar again"),
          ],
          const _MiddleSection(
            svgAsset: "assets/images/kyc/aadhaar.svg",
            title: "Verify Your Aadhaar",
            subtitle:
                "Secure your account with verified identity,\nIt only takes a moment, but protects for a lifetime",
          ),
          const SizedBox(height: 20),
          if (showCard) ...[
            _AadhaarCardWidget(aadhaar: state.kyc.aadhaar!),
          ] else if (showImages) ...[
            const Text(
              "Uploaded Aadhaar Cards",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _thumbnail(state.kyc.aadhaar!.frontImage!, "Front", context),
                const SizedBox(width: 12),
                _thumbnail(state.kyc.aadhaar!.backImage!, "Back", context),
              ],
            ),
          ] else
            _AadhaarActionsSection(
              onDigilockerTap: startDigilocker,
              onUploadTap: () => showAadhaarSheet(context),
            ),
        ],
      ),
    );
  }

  Widget _panStep(BuildContext context, KycState state) {
    return _PanStepContent(initialPan: state.kyc.pan?.panNumber ?? "");
  }

  Widget _bankStep(BuildContext context, KycState state) {
    return _BankStepContent(bank: state.kyc.bank ?? BankData());
  }

  Widget _gstStep(BuildContext context, KycState state) {
    return _GstStepContent(gst: state.kyc.gst ?? GstData());
  }

  Widget _reviewStep(BuildContext context, KycState state) {
    final kyc = state.kyc;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review Your Details",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Verify all your information before final submission.",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 32),
          _ReviewItem(label: "PAN NUMBER", value: kyc.pan?.panNumber ?? "N/A"),
          _ReviewItem(
            label: "BANK HOLDER",
            value: kyc.bank?.accountHolderName ?? "N/A",
          ),
          _ReviewItem(
            label: "ACCOUNT NUMBER",
            value: kyc.bank?.accountNumber ?? "N/A",
          ),
          _ReviewItem(label: "IFSC CODE", value: kyc.bank?.ifscCode ?? "N/A"),
          if (kyc.gst?.gstNumber != null)
            _ReviewItem(
              label: "GST Number",
              value: kyc.gst?.gstNumber ?? "N/A",
            ),
          if (kyc.gst?.gstImage != null && kyc.gst?.gstImage != "") ...[
            _ImageThumb(url: kyc.gst!.gstImage),
          ],
          const SizedBox(height: 24),
          if (kyc.aadhaar?.aadharName != null) ...[
            const SizedBox(height: 24),
            _AadhaarCardWidget(aadhaar: state.kyc.aadhaar!),
          ] else if (kyc.aadhaar?.frontImage != null) ...[
            const SizedBox(height: 24),
            Text(
              "AADHAAR IMAGES",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _ImageThumb(url: kyc.aadhaar!.frontImage!),
                const SizedBox(width: 12),
                _ImageThumb(url: kyc.aadhaar!.backImage!),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _termsStep(BuildContext context, KycState state) {
    return _TermsStepContent();
  }

  Widget _submittedStep(BuildContext context, KycState state, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.read(kycProvider.notifier).fetchKycStatus(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.assignment_turned_in,
                size: 80,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "KYC Verification Under Review",
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Reviewing your documents",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.orange.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Our team is reviewing your details and will get back within 1-2 business days.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 48),
            const _StatusRow(
              title: "Documents Submitted",
              subtitle: "KYC documents received successfully",
              isCompleted: true,
            ),
            const _StatusRow(
              title: "Verification in Progress",
              subtitle: "Team is reviewing your information",
              isActive: true,
            ),
            const _StatusRow(
              title: "Account Activation",
              subtitle: "Email notification once complete",
              isLocked: true,
            ),
            const SizedBox(height: 80),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E5BB1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Need Help?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                            children: [
                              const TextSpan(text: "Contact support at "),
                              TextSpan(
                                text: "kyc@sharkship.in",
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _thumbnail(String url, String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          width: 260,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                // The Image
                Image.network(
                  url,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.file(
                    File(url),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Subtle Aadhaar-style Overlay (Top Strip)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 6,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.white, Colors.green],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------- COMPONENTS -------------------

class _KycStepper extends StatelessWidget {
  final KycStep currentStep;
  const _KycStepper({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = KycStep.values.where((e) => e != KycStep.submitted).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: List.generate(steps.length, (index) {
          final isActive = steps[index].index <= currentStep.index;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (index != steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isActive ? Colors.blue : Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class AdminRemarksCard extends StatelessWidget {
  final String message;

  const AdminRemarksCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50, // Light orange background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.orange.shade200, // Orange border
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Warning Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Text Content (flexible)
          Expanded(
            child: Text(
              message, // "Please verify aadhaar again"
              style: TextStyle(
                color: Colors.orange.shade800,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionButton extends ConsumerWidget {
  const _BottomActionButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(kycProvider);
    final isLoading = asyncState.isLoading;
    final state = asyncState.value;

    if (state == null || state.currentStep == KycStep.submitted) {
      return const SizedBox.shrink();
    }

    final notifier = ref.read(kycProvider.notifier);
    String label = 'Next';
    VoidCallback? onPressed;

    switch (state.currentStep) {
      case KycStep.aadhaar:
        final aadharVerified = state.kyc.aadhaar?.isVerified ?? false;
        label = 'Next';
        onPressed = !aadharVerified
            ? notifier.fetchKycStatus
            : notifier.nextStep;
        break;
      case KycStep.pan:
        final panVerified = state.kyc.pan?.isVerified ?? false;
        label = !panVerified ? 'Verify PAN' : 'Next';
        onPressed = !panVerified ? notifier.verifyPanNumber : notifier.nextStep;
        break;
      case KycStep.bank:
        final bankVerified = state.kyc.bank?.isVerified ?? false;
        label = !bankVerified ? 'Verify & Next' : 'Next';
        onPressed = !bankVerified ? notifier.verifyBank : notifier.nextStep;
        break;
      case KycStep.gst:
        final gstVerified = state.kyc.gst?.isVerified ?? false;
        label = !gstVerified ? 'Verify & Next' : 'Next';
        onPressed = !gstVerified ? notifier.verifyGst : notifier.nextStep;
        break;
      case KycStep.review:
        label = 'Finalize Review';
        onPressed = notifier.submit;
        break;
      case KycStep.terms:
        label = 'Submit KYC';
        onPressed = state.isTermsAccepted ? notifier.acceptTerms : null;
        break;
      default:
        break;
    }

    final notShowBackButton =
        state.currentStep == KycStep.aadhaar ||
        (state.currentStep == KycStep.pan && !state.kyc.requiresAadhaar) ||
        state.currentStep == KycStep.terms;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!notShowBackButton) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: isLoading ? null : notifier.previousStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF1E5BB1)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Previous',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: GradientButton(
              text: label,
              isActive: !isLoading && onPressed != null,
              onTap: isLoading ? null : onPressed,
              child: isLoading
                  ? const ThreeDotsLoader(activeColor: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _PanStepContent extends ConsumerStatefulWidget {
  final String initialPan;
  const _PanStepContent({required this.initialPan});

  @override
  ConsumerState<_PanStepContent> createState() => _PanStepContentState();
}

class _PanStepContentState extends ConsumerState<_PanStepContent> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialPan);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _MiddleSection(
              svgAsset: "assets/images/kyc/aadhaar.svg",
              title: "Enter PAN Details",
              subtitle:
                  "Connect your PAN to stay compliant and safe,\nA small step for legal transparency.",
            ),
            const SizedBox(height: 24),

            _inputHelper(
              label: "PAN Card Number",
              context: context,
              hint: "",
              controller: controller,
              onChanged: (val) =>
                  ref.read(kycProvider.notifier).updatePan(val.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifiedBadge extends StatelessWidget {
  /// The size of the badge. Defaults to standard.
  final double scale;

  const VerifiedBadge({super.key, this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    // Colors for the badge
    const Color verifiedColor = Color(0xFF4CAF50); // A clean green
    const Color textColor = Colors.white;

    return Transform.scale(
      scale: scale, // Allows resizing if needed
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: verifiedColor,
          borderRadius: BorderRadius.circular(20), // Pill shape
          boxShadow: [
            BoxShadow(
              color: verifiedColor.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Takes minimal space
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: textColor,
              size: 16, // Small icon
            ),
            SizedBox(width: 6), // Spacing between icon and text
            Text(
              'Verified',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600, // Semi-bold for clarity
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BankStepContent extends ConsumerStatefulWidget {
  final BankData bank;
  const _BankStepContent({required this.bank});

  @override
  ConsumerState<_BankStepContent> createState() => _BankStepContentState();
}

class _BankStepContentState extends ConsumerState<_BankStepContent> {
  late final TextEditingController holder;
  late final TextEditingController acc;
  late final TextEditingController ifsc;
  late String type;

  @override
  void initState() {
    super.initState();
    holder = TextEditingController(text: widget.bank.accountHolderName);
    acc = TextEditingController(text: widget.bank.accountNumber);
    ifsc = TextEditingController(text: widget.bank.ifscCode);
    type = widget.bank.accountType.isEmpty
        ? "Savings"
        : widget.bank.accountType;
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(kycProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _MiddleSection(
              svgAsset: "assets/images/kyc/bank_details.svg",
              title: "Add Bank Details",
              subtitle:
                  "Link your bank for smooth payments,\n We make sure your money reaches the right place.",
            ),
            const SizedBox(height: 20),
            _inputHelper(
              label: "Account Holder Name",
              context: context,
              hint: "Enter Name",
              controller: holder,
              onChanged: (_) => _saveDraft(notifier),
            ),
            const SizedBox(height: 12),
            _inputHelper(
              label: "Account Number",
              context: context,
              hint: "Enter Account Number",
              controller: acc,
              onChanged: (_) => _saveDraft(notifier),
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _inputHelper(
              label: "IFSC Code",
              context: context,
              hint: "Enter IFSC",
              controller: ifsc,
              onChanged: (_) => _saveDraft(notifier),
            ),
            const SizedBox(height: 12),
            _Dropdown(
              label: "Account Type",
              value: type,
              items: const ["Savings", "Current"],
              onChanged: (v) {
                if (v != null) {
                  setState(() => type = v);
                  _saveDraft(notifier);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveDraft(KycNotifier notifier) {
    notifier.updateBank(
      BankData(
        accountHolderName: holder.text,
        accountNumber: acc.text,
        ifscCode: ifsc.text,
        accountType: type,
      ),
    );
  }
}

class _GstStepContent extends ConsumerStatefulWidget {
  final GstData gst;
  const _GstStepContent({required this.gst});

  @override
  ConsumerState<_GstStepContent> createState() => _GstStepContentState();
}

class _GstStepContentState extends ConsumerState<_GstStepContent> {
  late final TextEditingController controller;
  String? imagePath;

  Widget _thumbnail(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Image.file(File(url), width: 100, height: 100, fit: BoxFit.cover),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.gst.gstNumber);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(kycProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _MiddleSection(
              svgAsset: "assets/images/kyc/gst_details.svg",
              title: "GST Verification",
              subtitle:
                  "Add your GST for tax-ready invoices,\n Power your business with trusted billing.",
            ),
            const SizedBox(height: 24),
            _inputHelper(
              label: "GST Number",
              context: context,
              hint: "",
              controller: controller,
              onChanged: (val) => _saveDraft(notifier),
            ),
            const SizedBox(height: 20),
            _UploadCard(
              title: "Upload Gst Image",
              onTap: () async {
                final file = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (file != null) setState(() => imagePath = file.path);
              },
            ),
            if (imagePath != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: _thumbnail(imagePath!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _saveDraft(KycNotifier notifier) {
    notifier.updateGst(
      GstData(gstNumber: controller.text, gstImage: controller.text),
    );
  }
}

class _TermsStepContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(kycProvider);
    final notifier = ref.read(kycProvider.notifier);

    return asyncState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('No terms available.')),
      data: (state) {
        if (state.termsHtml == null || state.termsHtml!.isEmpty) {
          return const Center(child: Text('No terms available.'));
        }
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Terms & Conditions',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: SingleChildScrollView(
                    child: HtmlWidget(
                      state.termsHtml!,
                      textStyle: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                      renderMode: RenderMode.column,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: state.isTermsAccepted,
                    onChanged: (v) => notifier.toggleTerms(v ?? false),
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to all terms and conditions of Sharkship.',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _inputHelper({
  required String label,
  required BuildContext context,
  required String hint,
  required TextEditingController controller,
  TextInputType keyboard = TextInputType.text,
  ValueChanged<String>? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        keyboardType: keyboard,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              // CHANGED: from none
              color: Colors.grey, // Border color
              width: 1.5, // Border thickness
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    ],
  );
}

class _StatusRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;
  final bool isLocked;

  const _StatusRow({
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isActive = false,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isLocked ? Colors.black38 : Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (isCompleted) {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Color(0xFFC7F3D0),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 16, color: Color(0xFF1E8B42)),
      );
    }
    if (isActive) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: Color(0xFFD1E4FF),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFF1E5BB1),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Color(0xFFF0F0F0),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.lock_outline, size: 14, color: Colors.black26),
    );
  }
}

class _MiddleSection extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String subtitle;
  const _MiddleSection({
    required this.svgAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(svgAsset, height: 180),
        const SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.black54, height: 1.4),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final String label;
  final String value;
  const _ReviewItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _ImageThumb extends StatelessWidget {
  final String url;
  const _ImageThumb({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: url.startsWith("http")
            ? Image.network(url, fit: BoxFit.cover)
            : Image.file(File(url), fit: BoxFit.cover),
      ),
    );
  }
}

class _AadhaarActionsSection extends StatelessWidget {
  final VoidCallback onDigilockerTap;
  final VoidCallback onUploadTap;
  const _AadhaarActionsSection({
    required this.onDigilockerTap,
    required this.onUploadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _ActionButton(
            title: "Verify Using Digilocker",
            subtitle: "Instant Verification",
            icon: Icons.lock_outline,
            color: const Color(0xFF1E5BB1),
            onTap: onDigilockerTap,
          ),
          const SizedBox(height: 16),
          _ActionButton(
            title: "Upload Front & Back",
            subtitle: "Manual Upload",
            icon: Icons.upload_file_outlined,
            color: Colors.white,
            isOutlined: true,
            textColor: Colors.black,
            onTap: onUploadTap,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isOutlined;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isOutlined = false,
    this.textColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: isOutlined ? Border.all(color: Colors.grey.shade200) : null,
          boxShadow: [
            if (!isOutlined)
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isOutlined ? Colors.blue : Colors.white,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isOutlined ? Colors.grey : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _AadhaarUploadSheet extends ConsumerStatefulWidget {
  const _AadhaarUploadSheet();
  @override
  ConsumerState<_AadhaarUploadSheet> createState() =>
      _AadhaarUploadSheetState();
}

class _AadhaarUploadSheetState extends ConsumerState<_AadhaarUploadSheet> {
  String? frontPath;
  String? backPath;

  Widget _thumbnail(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            Image.file(File(url), width: 100, height: 100, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(kycProvider);
    final isLoading = asyncState.isLoading;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Upload Aadhaar Card',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _UploadCard(
            title: 'Front Side',
            imagePath: frontPath,
            onTap: () async {
              final file = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (file != null) setState(() => frontPath = file.path);
            },
          ),
          if (frontPath != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: _thumbnail(frontPath!),
            ),
          ],
          const SizedBox(height: 16),
          _UploadCard(
            title: 'Back Side',
            imagePath: backPath,
            onTap: () async {
              final file = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (file != null) setState(() => backPath = file.path);
            },
          ),
          if (backPath != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: _thumbnail(backPath!),
            ),
          ],
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: GradientButton(
              onTap: (frontPath != null && backPath != null && !isLoading)
                  ? () async {
                      await ref
                          .read(kycProvider.notifier)
                          .uploadAadhaar(frontPath!, backPath!);
                      // Close sheet only if still mounted and no error
                      if (mounted && asyncState.hasError == false) {
                        Navigator.pop(context);
                      }
                    }
                  : null,
              text: 'Verify & Upload',
              child: isLoading
                  ? const ThreeDotsLoader(activeColor: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback onTap;
  const _UploadCard({required this.title, this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.image_outlined, color: Colors.blue.shade700),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (imagePath != null)
              const Icon(Icons.check_circle, color: Colors.green)
            else
              const Icon(Icons.add_circle_outline, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _AadhaarCardWidget extends StatelessWidget {
  final AadhaarData aadhaar;
  const _AadhaarCardWidget({required this.aadhaar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (aadhaar.aadharProfileImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    aadhaar.aadharProfileImage!,
                    width: 70,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 70,
                      height: 80,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aadhaar.aadharName ?? "Verified User",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      aadhaar.aadharNumber ?? "XXXX XXXX XXXX",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text(
                "Aadhaar Verified Successfully",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
