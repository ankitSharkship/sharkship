import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/repositories/finance_repository.dart';

class VerifyBulkUseCase {
  final FinanceRepository repository;

  VerifyBulkUseCase(this.repository);

  Future<Either<Failure, void>> call(Map<String, dynamic> data) {
    return repository.verifyBulk(data);
  }
}
