import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/presentation/state/finance_providers.dart';
import '../repositories/finance_repository.dart';

part 'sync_billing_cycles.g.dart';

@riverpod
class SyncBillingCyclesUseCase extends _$SyncBillingCyclesUseCase {
  @override
  SyncBillingCyclesUseCase build() => this;

  Future<Either<Failure, void>> call() {
    return ref.read(financeRepositoryProvider).syncBillingCycles();
  }
}
