import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/network/dio_exception_handler.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import '../../domain/entities/user_balance.dart';
import 'user_providers.dart';

part 'user_balance_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserBalanceNotifier extends _$UserBalanceNotifier {
  @override
  FutureOr<UserBalance?> build() async {
    // Watch the user state. If the user changes or logs out,
    // this provider will automatically re-run or reset.
    final userAsync = ref.watch(userProvider);

    // If we're still loading the user or have no user, don't fetch balance yet
    if (userAsync.isLoading) return null;
    if (userAsync.value == null) return null;

    // We have a valid user, fetch the balance
    return _fetchBalance();
  }

  Future<UserBalance?> _fetchBalance() async {
    try {
      final useCase = ref.read(getUserBalanceUseCaseProvider);
      return await useCase();
    } catch (e) {
      throw DioExceptionHandler.handle(e);
    }
  }

  Future<void> fetchBalance() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchBalance());
  }
}
