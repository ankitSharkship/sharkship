import '../../domain/entities/user_balance.dart';
import '../../domain/repositories/user_repository.dart';

class GetUserBalanceUseCase {
  final UserRepository repository;

  GetUserBalanceUseCase(this.repository);

  Future<UserBalance> call() async {
    return await repository.getUserBalance();
  }
}
