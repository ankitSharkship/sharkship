import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/entities/cn_invoice_entity.dart';
import 'package:sharkship/features/finance/domain/repositories/finance_repository.dart';

class GetCnInvoicesUseCase {
  final FinanceRepository repository;

  GetCnInvoicesUseCase(this.repository);

  Future<Either<Failure, CnInvoiceResponseEntity>> call({
    required int total,
    required int skip,
    required String cnStartDate,
    required String cnEndDate,
    String? cnDateRangeStart,
    String? cnDateRangeEnd,
    String? state,
    String? invoiceNo,
  }) {
    return repository.getCnInvoices(
      total: total,
      skip: skip,
      cnStartDate: cnStartDate,
      cnEndDate: cnEndDate,
      cnDateRangeStart: cnDateRangeStart,
      cnDateRangeEnd: cnDateRangeEnd,
      state: state,
      invoiceNo: invoiceNo,
    );
  }
}
