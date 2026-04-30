import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/user/presentation/state/user_providers.dart';

part 'change_password_notifier.g.dart';

enum ChangePasswordStep { passwordEntry, otpVerification, success }

class ChangePasswordState {
  final ChangePasswordStep step;
  final bool isLoading;
  final String? error;
  final String? verifyId;
  final int resendCooldownSeconds;

  const ChangePasswordState({
    this.step = ChangePasswordStep.passwordEntry,
    this.isLoading = false,
    this.error,
    this.verifyId,
    this.resendCooldownSeconds = 0,
  });

  ChangePasswordState copyWith({
    ChangePasswordStep? step,
    bool? isLoading,
    String? error,
    String? verifyId,
    int? resendCooldownSeconds,
    bool clearError = false,
  }) {
    return ChangePasswordState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      verifyId: verifyId ?? this.verifyId,
      resendCooldownSeconds:
          resendCooldownSeconds ?? this.resendCooldownSeconds,
    );
  }
}

@riverpod
class ChangePasswordNotifier extends _$ChangePasswordNotifier {
  @override
  ChangePasswordState build() => const ChangePasswordState();

  /// Step 1: validate passwords then send OTP.
  Future<void> generateOtp({
    required String phoneNo,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      state = state.copyWith(error: 'Please fill in both password fields.');
      return;
    }
    if (newPassword.length < 8) {
      state = state.copyWith(error: 'Password must be at least 8 characters.');
      return;
    }
    if (newPassword != confirmPassword) {
      state = state.copyWith(error: 'Passwords do not match.');
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final verifyId = await ref
          .read(generateOtpForPasswordUseCaseProvider)
          .call(phoneNo);

      state = state.copyWith(
        isLoading: false,
        step: ChangePasswordStep.otpVerification,
        verifyId: verifyId,
        resendCooldownSeconds: 30,
      );

      _startResendTimer();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
    }
  }

  /// Step 2: verify OTP and update password.
  Future<void> verifyOtpAndChangePassword({
    required String otp,
    required String newPassword,
    required BuildContext context,
  }) async {
    if (otp.length != 4) {
      state = state.copyWith(error: 'Please enter the 6-digit OTP.');
      return;
    }
    if (state.verifyId == null) return;

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await ref
          .read(changePasswordUseCaseProvider)
          .call(verifyId: state.verifyId!, otp: otp, newPassword: newPassword);

      state = state.copyWith(
        isLoading: false,
        step: ChangePasswordStep.success,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
    }
  }

  /// Resend OTP — available only after cooldown expires.
  Future<void> resendOtp(String phoneNo) async {
    if (state.resendCooldownSeconds > 0) return;

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final verifyId = await ref
          .read(generateOtpForPasswordUseCaseProvider)
          .call(phoneNo);

      state = state.copyWith(
        isLoading: false,
        verifyId: verifyId,
        resendCooldownSeconds: 30,
      );

      _startResendTimer();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
    }
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  void reset() {
    state = const ChangePasswordState();
  }

  void _startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!ref.mounted) return false;
      final current = state.resendCooldownSeconds;
      if (current <= 0) return false;
      state = state.copyWith(resendCooldownSeconds: current - 1);
      return current - 1 > 0;
    });
  }

  String _extractError(Object e) {
    final msg = e.toString();
    if (msg.contains('Exception:')) {
      return msg.replaceFirst('Exception: ', '');
    }
    return 'Something went wrong. Please try again.';
  }
}
