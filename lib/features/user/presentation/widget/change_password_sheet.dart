import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/user/presentation/state/change_password_notifier.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';

/// Call this to show the Change Password modal sheet.
Future<void> showChangePasswordSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _ChangePasswordSheet(),
  );
}

class _ChangePasswordSheet extends ConsumerStatefulWidget {
  const _ChangePasswordSheet();

  @override
  ConsumerState<_ChangePasswordSheet> createState() =>
      _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends ConsumerState<_ChangePasswordSheet> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();

  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ChangePasswordState>(changePasswordProvider, (_, next) {
      if (next.step == ChangePasswordStep.success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(changePasswordProvider.notifier).reset();
      }
    });

    final state = ref.watch(changePasswordProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          ref.read(changePasswordProvider.notifier).reset();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFE8F4FD),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: state.step == ChangePasswordStep.otpVerification
              ? _OtpStep(
                  key: const ValueKey('otp'),
                  state: state,
                  otpController: _otpController,
                  newPassword: _newPasswordController.text,
                )
              : _PasswordStep(
                  key: const ValueKey('password'),
                  state: state,
                  newPasswordController: _newPasswordController,
                  confirmPasswordController: _confirmPasswordController,
                  showNewPassword: _showNewPassword,
                  showConfirmPassword: _showConfirmPassword,
                  onToggleNewPassword: () =>
                      setState(() => _showNewPassword = !_showNewPassword),
                  onToggleConfirmPassword: () => setState(
                    () => _showConfirmPassword = !_showConfirmPassword,
                  ),
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step 1 — Password Entry
// ─────────────────────────────────────────────────────────────────────────────

class _PasswordStep extends ConsumerWidget {
  final ChangePasswordState state;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool showNewPassword;
  final bool showConfirmPassword;
  final VoidCallback onToggleNewPassword;
  final VoidCallback onToggleConfirmPassword;

  const _PasswordStep({
    super.key,
    required this.state,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.showNewPassword,
    required this.showConfirmPassword,
    required this.onToggleNewPassword,
    required this.onToggleConfirmPassword,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(changePasswordProvider.notifier);
    final user = ref.read(userProvider).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Handle bar
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Title
        const Row(
          children: [
            Text(
              'Change Your Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Please enter your new password and confirm it.',
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
        const SizedBox(height: 24),

        // New Password
        _FieldLabel('New Password'),
        const SizedBox(height: 6),
        _PasswordField(
          controller: newPasswordController,
          hint: 'Enter New Password',
          obscure: !showNewPassword,
          onToggle: onToggleNewPassword,
          onChanged: (_) => notifier.clearError(),
        ),
        const SizedBox(height: 16),

        // Confirm Password
        _FieldLabel('Confirm Password'),
        const SizedBox(height: 6),
        _PasswordField(
          controller: confirmPasswordController,
          hint: 'Confirm Password',
          obscure: !showConfirmPassword,
          onToggle: onToggleConfirmPassword,
          onChanged: (_) => notifier.clearError(),
        ),

        // Error
        if (state.error != null) ...[
          const SizedBox(height: 12),
          _ErrorBanner(message: state.error!),
        ],

        const SizedBox(height: 24),

        // Generate OTP button
        GradientButton(
          text: 'Generate OTP',
          isActive: !state.isLoading,
          onTap: state.isLoading
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  notifier.generateOtp(
                    phoneNo: user?.phoneNo ?? '',
                    newPassword: newPasswordController.text,
                    confirmPassword: confirmPasswordController.text,
                  );
                },
          child: state.isLoading ? CircularProgressIndicator() : null,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Step 2 — OTP Verification
// ─────────────────────────────────────────────────────────────────────────────

class _OtpStep extends ConsumerWidget {
  final ChangePasswordState state;
  final TextEditingController otpController;
  final String newPassword;

  const _OtpStep({
    super.key,
    required this.state,
    required this.otpController,
    required this.newPassword,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(changePasswordProvider.notifier);
    final user = ref.read(userProvider).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Handle
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Title
        const Row(
          children: [
            Text(
              'Enter OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'A 4-digit OTP has been sent to +91 ${user?.phoneNo ?? ''}.',
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
        const SizedBox(height: 24),

        // OTP input
        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 12,
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: '- - - -',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 28,
              letterSpacing: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
          onChanged: (_) => notifier.clearError(),
        ),

        // Error
        if (state.error != null) ...[
          const SizedBox(height: 12),
          _ErrorBanner(message: state.error!),
        ],

        const SizedBox(height: 16),

        // Resend row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Didn't receive OTP? ",
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            GestureDetector(
              onTap: state.resendCooldownSeconds > 0 || state.isLoading
                  ? null
                  : () => notifier.resendOtp(user?.phoneNo ?? ''),
              child: Text(
                state.resendCooldownSeconds > 0
                    ? 'Resend in ${state.resendCooldownSeconds}s'
                    : 'Resend OTP',
                style: TextStyle(
                  color: state.resendCooldownSeconds > 0
                      ? Colors.grey
                      : Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        GradientButton(
          text: 'Verify & Change Password',
          onTap: state.isLoading
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  notifier.verifyOtpAndChangePassword(
                    otp: otpController.text,
                    newPassword: newPassword,
                    context: context,
                  );
                },
          child: state.isLoading ? CircularProgressIndicator() : null,
        ),

        // Verify & Change Password
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared small widgets
// ─────────────────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const Text(' *', style: TextStyle(color: Colors.orange)),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback onToggle;
  final void Function(String)? onChanged;

  const _PasswordField({
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.onToggle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.grey.shade500,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.red.shade700, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
