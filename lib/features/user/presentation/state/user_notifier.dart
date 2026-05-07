import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import '../../domain/entities/user.dart';
import 'user_providers.dart';
import 'package:sharkship/core/network/dio_exception_handler.dart';

part 'user_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  AsyncValue<User?> build() {
    _init();
    return const AsyncValue.loading();
  }

  Future<void> _init() async {
    final repository = ref.read(userRepositoryProvider);
    final authService = ref.read(authServiceProvider);

    try {
      final token = await authService.getToken();
      if (token == null || token.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }

      final localUser = await repository.getUserFromLocalStorage();
      if (!ref.mounted) return;

      if (localUser != null) {
        state = AsyncValue.data(localUser);
        _fetchAndUpdate();
      } else {
        await fetchUserDetails();
      }
    } catch (_) {
      // If even token check fails, assume logged out
      state = const AsyncValue.data(null);
    }
  }

  Future<void> _fetchAndUpdate() async {
    try {
      final useCase = ref.read(getUserDetailsUseCaseProvider);
      final user = await useCase();

      if (!ref.mounted) return;

      state = AsyncValue.data(user);
    } catch (_) {
      // ignore errors in background refresh
    }
  }

  Future<void> fetchUserDetails() async {
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(getUserDetailsUseCaseProvider);
      final user = await useCase();
      if (!ref.mounted) return;
      state = AsyncValue.data(user);
    } catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncValue.error(DioExceptionHandler.handle(e), st);
    }
  }

  void clearUser() async {
    final repository = ref.read(userRepositoryProvider);
    await repository.clearUserFromLocalStorage();
    state = const AsyncValue.data(null);
  }
}
