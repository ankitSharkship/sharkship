import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/features/user/presentation/state/user_providers.dart';

part 'edit_profile_notifier.g.dart';

enum EditProfileStep { form, otpVerification, success }

class EditProfileState {
  final EditProfileStep step;
  final bool isLoading;
  final String? error;
  final String? verifyId;
  final int resendCooldownSeconds;

  const EditProfileState({
    this.step = EditProfileStep.form,
    this.isLoading = false,
    this.error,
    this.verifyId,
    this.resendCooldownSeconds = 0,
  });

  EditProfileState copyWith({
    EditProfileStep? step,
    bool? isLoading,
    String? error,
    String? verifyId,
    int? resendCooldownSeconds,
    bool clearError = false,
  }) {
    return EditProfileState(
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
class EditProfileNotifier extends _$EditProfileNotifier {
  @override
  EditProfileState build() => const EditProfileState();

  /// Step 1 → validates form, sends OTP, advances to OTP step.
  Future<void> submitForm({
    required String phoneNo,
    required String firstName,
    required String lastName,
    required String email,
    required String businessName,
    required String typeOfBusiness,
  }) async {
    if (firstName.trim().isEmpty || lastName.trim().isEmpty) {
      state = state.copyWith(error: 'First name and last name are required.');
      return;
    }
    if (email.trim().isEmpty || !_isValidEmail(email)) {
      state = state.copyWith(error: 'Please enter a valid email address.');
      return;
    }
    if (phoneNo.trim().length < 10) {
      state = state.copyWith(
        error: 'Please enter a valid 10-digit phone number.',
      );
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final verifyId = await ref
          .read(generateOtpForPasswordUseCaseProvider)
          .call(phoneNo.trim());

      state = state.copyWith(
        isLoading: false,
        step: EditProfileStep.otpVerification,
        verifyId: verifyId,
        resendCooldownSeconds: 30,
      );

      _startResendTimer();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
    }
  }

  /// Step 2 → verifies OTP and calls updatePersonalInfo.
  Future<void> verifyOtpAndUpdate({
    required String otp,
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNo,
    required String businessName,
    required String typeOfBusiness,
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
          .read(updatePersonalInfoUseCaseProvider)
          .call(
            userId: userId,
            firstName: firstName.trim(),
            lastName: lastName.trim(),
            email: email.trim(),
            phoneNo: phoneNo.trim(),
            businessName: businessName.trim(),
            typeOfBusiness: typeOfBusiness,
            otp: otp,
            verifyId: state.verifyId!,
          );

      // Refresh user data in cache after successful update
      ref.read(userProvider.notifier).fetchUserDetails();

      state = state.copyWith(isLoading: false, step: EditProfileStep.success);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
    }
  }

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

  void clearError() => state = state.copyWith(clearError: true);

  void reset() => state = const EditProfileState();

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

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(email);
  }

  String _extractError(Object e) {
    final msg = e.toString();
    if (msg.contains('Exception:')) {
      return msg.replaceFirst('Exception: ', '');
    }
    return 'Something went wrong. Please try again.';
  }
}
