import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import 'user_providers.dart';

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

    try {
      final localUser = await repository.getUserFromLocalStorage();

      if (!ref.mounted) return;

      if (localUser != null) {
        state = AsyncValue.data(localUser);

        // Fire API in background (no await)
        _fetchAndUpdate();
      } else {
        // No local → fetch normally
        await fetchUserDetails();
      }
    } catch (_) {
      await fetchUserDetails();
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

  // Future<void> _loadFromLocal() async {
  //   try {
  //     final repository = ref.read(userRepositoryProvider);
  //     final user = await repository.getUserFromLocalStorage();
  //     if (!ref.mounted) return;
  //     if (user != null) {
  //       state = AsyncValue.data(user);
  //     }
  //     await fetchUserDetails();
  //   } catch (e) {
  //     // Don't set error here, let fetch handle it
  //   }
  // }

  Future<void> fetchUserDetails() async {
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(getUserDetailsUseCaseProvider);
      final user = await useCase();
      if (!ref.mounted) return; // Added check
      state = AsyncValue.data(user);
    } catch (e, st) {
      if (!ref.mounted) return; // Added check
      state = AsyncValue.error(e, st);
    }
  }

  void clearUser() async {
    final repository = ref.read(userRepositoryProvider);
    await repository.clearUserFromLocalStorage();
    state = const AsyncValue.data(null);
  }
}
