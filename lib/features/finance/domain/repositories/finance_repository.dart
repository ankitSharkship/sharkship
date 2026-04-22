import '../../domain/entities/shipping_rate_entity.dart';
import '../../domain/entities/calculator_rate_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/message_metrics_entity.dart';
import '../../domain/entities/message_transaction_entity.dart';

abstract class FinanceRepository {
  Future<List<ShippingRateEntity>> getShippingRates({
    required String serviceType,
  });

  Future<List<CalculatorRateEntity>> calculateShippingRate({
    required String source,
    required String destination,
    required String paymentType,
    required double weight,
    required double productValue,
    required double length,
    required double width,
    required double height,
    required String serviceType,
    required String provider,
  });

  Future<TransactionResponse> getTransactions({
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
  });

  Future<MessageMetricsEntity> getMessageMetrics({
    required String startDate,
    required String endDate,
  });

  Future<MessageTransactionsResponse> getMessageTransactions({
    required int take,
    required int skip,
    required String startDate,
    required String endDate,
  });
}
