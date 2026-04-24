import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/entities/tax_invoice_entity.dart';
import 'package:sharkship/features/finance/domain/repositories/finance_repository.dart';
import 'package:sharkship/features/finance/data/repositories/finance_repository_impl.dart';
import 'package:sharkship/features/finance/presentation/state/invoices_summary_notifier.dart';

part 'get_tax_invoices_usecase.g.dart';



class GetTaxInvoicesUseCase {
  final FinanceRepository repository;

  GetTaxInvoicesUseCase(this.repository);

  Future<Either<Failure, TaxInvoiceResponseEntity>> call(TaxInvoiceParams params) {
    return repository.getTaxInvoices(
      total: params.total,
      skip: params.skip,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

@riverpod
GetTaxInvoicesUseCase getTaxInvoicesUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetTaxInvoicesUseCase(repository);
}
