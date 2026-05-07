import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/network/dio_exception_handler.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/features/auth/data/models/register_user_request_model.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/user/presentation/state/user_balance_notifier.dart';
import 'auth_providers.dart';
import '../../../user/presentation/state/user_notifier.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> generateOtp(
    String phoneNo,
    void Function(String verifyId) onSuccess,
  ) async {
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(generateOtpUseCaseProvider);
      final response = await useCase(phoneNo);
      state = const AsyncValue.data(null);
      onSuccess(response.verifyId);
    } catch (e, st) {
      state = AsyncValue.error(DioExceptionHandler.handle(e), st);
    }
  }

  Future<void> otpLogin(
    String phoneNo,
    String verifyId,
    String otp,
    void Function() onSuccess,
  ) async {
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(otpLoginUseCaseProvider);
      // Wait for the login use case to finish
      await useCase(phoneNo, verifyId, otp);
      await ref.read(userProvider.notifier).fetchUserDetails();
      state = const AsyncValue.data(null);
      onSuccess();
    } catch (e, st) {
      state = AsyncValue.error(DioExceptionHandler.handle(e), st);
    }
  }

  Future<void> passwordLogin(
    String phoneNo,
    String password,
    void Function() onSuccess,
  ) async {
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(passwordLoginUseCaseProvider);
      await useCase(phoneNo, password);
      await ref.read(userProvider.notifier).fetchUserDetails();
      state = const AsyncValue.data(null);
      onSuccess();
    } catch (e, st) {
      state = AsyncValue.error(DioExceptionHandler.handle(e), st);
    }
  }

  Future<void> logout(
    void Function() onSuccess, {
    bool allSession = false,
  }) async {
    final useCase = ref.read(logoutUseCaseProvider);
    try {
      // 1. Call logout API while token is still present
      await useCase(allSession: allSession);
    } catch (_) {
      // Ignore API failure and proceed with local logout
    }

    // 2. Reset relevant providers before navigating
    // ref.invalidate(userProvider);
    // ref.invalidate(userBalanceProvider);
    // ref.invalidate(bottomNavProvider);
    ref.read(appContainerKeyProvider.notifier).state = UniqueKey();

    // 3. Trigger navigation
    onSuccess();
  }

  Future<void> authenticate(
    String phone,
    void Function(String verifyId) onSuccess,
  ) async {
    state = const AsyncValue.loading();

    try {
      final usecase = ref.read(authenticateUserUseCaseProvider);
      final response = await usecase(phone);

      state = const AsyncValue.data(null);

      onSuccess(response.verifyId);
    } catch (e, st) {
      state = AsyncValue.error(DioExceptionHandler.handle(e), st);
    }
  }

  Future<void> registerUser({
    required RegisterUserRequestModel request,
    required void Function() onSuccess,
  }) async {
    state = const AsyncLoading();

    try {
      final usecase = ref.read(registerUserUseCaseProvider);

      await usecase(request);

      // fetch user after registration
      await ref.read(userProvider.notifier).fetchUserDetails();

      state = const AsyncValue.data(null);

      onSuccess();
    } catch (e, st) {
      state = AsyncValue.error(DioExceptionHandler.handle(e), st);
    }
  }
}
