import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/repositories/finance_repository.dart';

class VerifySingleUseCase {
  final FinanceRepository repository;

  VerifySingleUseCase(this.repository);

  Future<Either<Failure, void>> call(Map<String, dynamic> data) {
    return repository.verifySingle(data);
  }
}
