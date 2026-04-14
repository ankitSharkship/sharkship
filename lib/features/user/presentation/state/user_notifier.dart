import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import 'user_providers.dart';
import 'user_balance_notifier.dart';

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
        fetchUserBalance();
      } else {
        // No local → fetch normally
        await fetchUserDetails();
        await fetchUserBalance();
      }
    } catch (_) {
      await fetchUserDetails();
      await fetchUserBalance();
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
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchUserBalance() async {
    try {
      await ref.read(userBalanceProvider.notifier).fetchBalance();
    } catch (_) {
      // handled in balance notifier state
    }
  }

  void clearUser() async {
    final repository = ref.read(userRepositoryProvider);
    await repository.clearUserFromLocalStorage();
    state = const AsyncValue.data(null);
  }
}
