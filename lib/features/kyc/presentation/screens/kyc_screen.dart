import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_notifier.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_state.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class KycScreen extends ConsumerWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kycProvider);

    ref.listen(kycProvider, (prev, next) {
      if (next.error != null && next.error != prev?.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // ---------- STEPPER ----------
            _KycStepper(currentStep: state.currentStep),

            // ---------- CONTENT ----------
            Expanded(child: _buildStepContent(state.currentStep, context)),

            // ---------- BUTTON ----------
            // _BottomActionButton(state: state),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(KycStep step, BuildContext context) {
    switch (step) {
      case KycStep.aadhaar:
        return _aadhaarStep(context);
      case KycStep.pan:
        return _panStep();
      case KycStep.bank:
        return _bankStep();
      case KycStep.gst:
        return _gstStep();
      case KycStep.review:
        return _reviewStep();
      case KycStep.submitted:
        return const Center(child: Text("Submitted"));
    }
  }

  Widget _aadhaarStep(BuildContext context) {
    void showAadhaarUploadSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => ProviderScope(
          overrides: [], // Not needed, just ensuring context
          child: const _AadhaarUploadSheet(),
        ),
      );
    }

    return Column(
      children: [
        _MiddleSection(
          svgAsset: "assets/images/kyc/aadhaar.svg",
          title: "Verify Your Aadhaar",
          subtitle:
              "Secure your account with verified identity,\nIt only takes a moment, but protects for a lifetime",
        ),
        const SizedBox(height: 20),
        _AadhaarActionsSection(
          onDigilockerTap: () {},
          onUploadTap: () {
            showAadhaarUploadSheet(context);
          },
        ),
      ],
    );
  }

  Widget _panStep() {
    return Column(
      children: [
        _MiddleSection(
          svgAsset: "assets/images/kyc/aadhaar.svg",
          title: "Enter PAN Details",
          subtitle:
              "Connect your PAN to stay compliant and safe,\nA small step for legal transparency.",
        ),
      ],
    );
  }

  Widget _bankStep() {
    return Column(
      children: [
        _MiddleSection(
          svgAsset: "assets/images/kyc/bank_details.svg",
          title: "Add Your Bank Info",
          subtitle:
              "Link your bank for smooth payments,\n We make sure your money reaches the right place.",
        ),
      ],
    );
  }

  Widget _gstStep() {
    return Column(
      children: [
        _MiddleSection(
          svgAsset: "assets/images/kyc/gst_details.svg",
          title: "GST Verification",
          subtitle:
              "Add your GST for tax-ready invoices,\n Power your business with trusted billing.",
        ),
      ],
    );
  }

  Widget _reviewStep() {
    return const SizedBox();
  }

  Widget _input({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    TextInputType keyboard = TextInputType.text,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          // If validator is null, it just returns null (valid) by default
          validator: validator,
          keyboardType: keyboard,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 18),
                    onPressed: () {
                      controller.clear();
                      if (onChanged != null) onChanged('');
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class _KycStepper extends StatelessWidget {
  final KycStep currentStep;

  const _KycStepper({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      KycStep.aadhaar,
      KycStep.pan,
      KycStep.bank,
      KycStep.gst,
      KycStep.review,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isActive = step.index <= currentStep.index;

          return Expanded(
            child: Row(
              children: [
                // Circle
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),

                // Line
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

class _BottomActionButton extends ConsumerWidget {
  final KycState state;

  const _BottomActionButton({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(kycProvider.notifier);

    String label;
    VoidCallback? onPressed;

    switch (state.currentStep) {
      case KycStep.aadhaar:
        label = "Verify Aadhaar";
        onPressed = null;
        break;

      case KycStep.pan:
        label = "Verify PAN";
        onPressed = () {
          // PAN step should call notifier internally
        };
        break;

      case KycStep.bank:
        label = "Verify Bank";
        onPressed = () {};
        break;

      case KycStep.gst:
        label = "Next";
        onPressed = () {};
        break;

      case KycStep.review:
        label = "Submit";
        onPressed = notifier.submit;
        break;

      case KycStep.submitted:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
        ),
        child: state.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Text(label),
      ),
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
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    if (isKeyboardOpen) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ---------- SVG ----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SvgPicture.asset(svgAsset, height: 220, fit: BoxFit.contain),
        ),

        const SizedBox(height: 24),

        // ---------- TITLE ----------
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D8CFF),
          ),
        ),

        const SizedBox(height: 12),

        // ---------- SUBTITLE ----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ),
      ],
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
    return Column(
      children: [
        // ---------- DIGILOCKER BUTTON ----------
        GestureDetector(
          onTap: onDigilockerTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Replace with your asset
                Image.asset("assets/images/kyc/digi_locker.jpeg", height: 40),
                const SizedBox(width: 10),
                const Text(
                  "Verify Using Digilocker",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D8CFF),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ---------- OR ----------
        const Text("Or", style: TextStyle(color: Colors.black54, fontSize: 14)),

        const SizedBox(height: 14),

        // ---------- UPLOAD BUTTON ----------
        GestureDetector(
          onTap: onUploadTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2D8CFF), Color(0xFF56CCF2)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.upload_outlined, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "Upload Aadhaar",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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

class _AadhaarUploadSheet extends ConsumerStatefulWidget {
  const _AadhaarUploadSheet();

  @override
  ConsumerState<_AadhaarUploadSheet> createState() => _AadhaarUploadSheetState();
}

class _AadhaarUploadSheetState extends ConsumerState<_AadhaarUploadSheet> {
  String? frontPath;
  String? backPath;

  bool get isValid => frontPath != null && backPath != null;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(kycProvider);
    final notifier = ref.read(kycProvider.notifier);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF4F6F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---------- HANDLE ----------
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // ---------- FRONT ----------
              _UploadCard(
                title: "Front Of Aadhar Card",
                buttonText: "Upload Front Side",
                imagePath: frontPath,
                onTap: () async {
                  final path = await _pickImage();
                  if (path != null) {
                    setState(() => frontPath = path);
                  }
                },
              ),

              const SizedBox(height: 16),

              // ---------- BACK ----------
              _UploadCard(
                title: "Back Of Aadhar Card",
                buttonText: "Upload Back Side",
                imagePath: backPath,
                onTap: () async {
                  final path = await _pickImage();
                  if (path != null) {
                    setState(() => backPath = path);
                  }
                },
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (isValid && !state.isLoading)
                      ? () async {
                          await notifier.uploadAadhaar(frontPath!, backPath!);
                          if (mounted && state.error == null) {
                            Navigator.pop(context);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF2D8CFF),
                    disabledBackgroundColor: Colors.blue.shade100,
                  ),
                  child: state.isLoading
                      ? const ThreeDotsLoader(activeColor: Colors.white)
                      : const Text("Upload Aadhaar"),
                ),
              ),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- IMAGE PICKER ----------
  Future<String?> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, // Compressing for better performance
    );
    return picked?.path;
  }
}

class _UploadCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final String? imagePath;
  final VoidCallback onTap;

  const _UploadCard({
    required this.title,
    required this.buttonText,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- TITLE ----------
        Row(
          children: [
            const Icon(Icons.badge_outlined, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // ---------- CARD ----------
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(
            children: [
              // Upload Button
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue),
                    color: imagePath != null ? Colors.blue.withOpacity(0.05) : null,
                  ),
                  child: Row(
                    children: [
                      if (imagePath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(imagePath!),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        const Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.blue,
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          imagePath != null ? "Change Image" : buttonText,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (imagePath != null)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Info
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("• Max File Size: 500KB"),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("• File Type: .png, .jpeg, .jpg, .webp"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
