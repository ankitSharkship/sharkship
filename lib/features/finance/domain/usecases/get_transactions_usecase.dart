import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/finance_repository.dart';

class GetTransactionsUseCase {
  final FinanceRepository _repository;

  GetTransactionsUseCase(this._repository);

  Future<TransactionResponse> execute({
    int total = 10,
    int skip = 0,
    String? transactionType,
    String? affectedBalance,
    String? transactionCategory,
    String? startDate,
    String? endDate,
    String? isWallet,
    String? paymentGateway,
    String? journeyType,
    String? trackingId,
    String? orderId,
    String? paymentGatewayId,
  }) {
    return _repository.getTransactions(
      total: total,
      skip: skip,
      transactionType: transactionType,
      affectedBalance: affectedBalance,
      transactionCategory: transactionCategory,
      startDate: startDate,
      endDate: endDate,
      isWallet: isWallet,
      paymentGateway: paymentGateway,
      journeyType: journeyType,
      trackingId: trackingId,
      orderId: orderId,
      paymentGatewayId: paymentGatewayId,
    );
  }
}
