import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/entities/initiate_invoice_entity.dart';
import 'package:sharkship/features/finance/domain/repositories/finance_repository.dart';

class InitiateInvoiceUseCase {
  final FinanceRepository repository;

  InitiateInvoiceUseCase(this.repository);

  Future<Either<Failure, InitiateInvoiceEntity>> call() {
    return repository.initiateInvoice();
  }
}
