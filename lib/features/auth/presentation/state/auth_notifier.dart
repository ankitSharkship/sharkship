import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/auth/data/models/register_user_request_model.dart';
import 'auth_providers.dart';
import '../../../user/presentation/state/user_notifier.dart';

part 'auth_notifier.g.dart';

@riverpod
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
      state = AsyncValue.error(e, st);
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
      state = AsyncValue.error(e, st);
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
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout(
    void Function() onSuccess, {
    bool allSession = false,
  }) async {
    final useCase = ref.read(logoutUseCaseProvider);
    try {
      await useCase(allSession: allSession);
    } catch (_) {}
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
      state = AsyncValue.error(e, st);
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
      state = AsyncValue.error(e, st);
    }
  }
}
