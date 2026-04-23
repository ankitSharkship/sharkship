import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/entities/remittance_entity.dart';
import 'package:sharkship/features/finance/domain/repositories/finance_repository.dart';

class GetRemittanceDetailsUseCase {
  final FinanceRepository repository;

  GetRemittanceDetailsUseCase(this.repository);

  Future<Either<Failure, RemittanceDetails>> call() async {
    return await repository.getRemittanceDetails();
  }
}
