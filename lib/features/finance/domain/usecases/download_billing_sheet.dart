import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/presentation/state/finance_providers.dart';
import '../repositories/finance_repository.dart';

part 'download_billing_sheet.g.dart';

@riverpod
class DownloadBillingSheetUseCase extends _$DownloadBillingSheetUseCase {
  @override
  DownloadBillingSheetUseCase build() => this;

  Future<Either<Failure, void>> call(String id) {
    return ref.read(financeRepositoryProvider).downloadBillingSheet(id);
  }
}
