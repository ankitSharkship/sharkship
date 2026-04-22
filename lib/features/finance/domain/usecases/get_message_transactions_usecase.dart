import '../entities/message_transaction_entity.dart';
import '../repositories/finance_repository.dart';

class GetMessageTransactionsUseCase {
  final FinanceRepository _repository;

  GetMessageTransactionsUseCase(this._repository);

  Future<MessageTransactionsResponse> execute({
    required int take,
    required int skip,
    required String startDate,
    required String endDate,
  }) {
    return _repository.getMessageTransactions(
      take: take,
      skip: skip,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
