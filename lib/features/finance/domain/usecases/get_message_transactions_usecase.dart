import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/presentation/state/transactions_notifier.dart';
import '../entities/message_transaction_entity.dart';
import '../repositories/finance_repository.dart';
import '../../data/repositories/finance_repository_impl.dart';

part 'get_message_transactions_usecase.g.dart';

class GetMessageTransactionsUseCase {
  final FinanceRepository _repository;

  GetMessageTransactionsUseCase(this._repository);

  Future<Either<Failure, MessageTransactionsResponse>> execute(
      TransactionsParams params) {
    return _repository.getMessageTransactions(params);
  }
}

@riverpod
GetMessageTransactionsUseCase getMessageTransactionsUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetMessageTransactionsUseCase(repository);
}
