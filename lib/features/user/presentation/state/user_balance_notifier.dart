import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user_balance.dart';
import 'user_providers.dart';

part 'user_balance_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserBalanceNotifier extends _$UserBalanceNotifier {
  @override
  AsyncValue<UserBalance?> build() {
    fetchBalance();
    return const AsyncValue.data(null);
  }

  Future<void> fetchBalance() async {
    state = const AsyncValue.loading();
    try {
      final useCase = ref.read(getUserBalanceUseCaseProvider);
      final balance = await useCase();
      state = AsyncValue.data(balance);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
