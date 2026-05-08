import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import '../entities/billing_cycle_entity.dart';
import '../repositories/finance_repository.dart';
import 'package:sharkship/features/finance/data/repositories/finance_repository_impl.dart';

part 'get_billing_cycles.g.dart';

class GetBillingCyclesUseCase {
  final FinanceRepository repository;

  GetBillingCyclesUseCase(this.repository);

  Future<Either<Failure, BillingSummaryEntity>> call({
    required int total,
    required int skip,
    required String startDate,
    required String endDate,
    required String dateQuery,
    String? status
  }) {
    return repository.getBillingCycles(
      total: total,
      skip: skip,
      startDate: startDate,
      endDate: endDate,
      dateQuery: dateQuery,
      status: status
    );
  }
}

@riverpod
GetBillingCyclesUseCase getBillingCyclesUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetBillingCyclesUseCase(repository);
}
