import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/presentation/state/transactions_notifier.dart';
import '../../domain/entities/shipping_rate_entity.dart';
import '../../domain/entities/calculator_rate_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/message_metrics_entity.dart';
import '../../domain/entities/message_transaction_entity.dart';
import '../../domain/entities/remittance_entity.dart';

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

  Future<Either<Failure, MessageTransactionsResponse>> getMessageTransactions(
      TransactionsParams params);

  Future<Either<Failure, RemittanceDetails>> getRemittanceDetails();

  Future<Either<Failure, RemittanceCycleResponse>> getRemittanceCycles({
    required int total,
    required int skip,
    required String startDate,
    required String endDate,
    String? status,
    String? businessName,
    String? remittanceId,
    String? userId,
    String? phone,
  });
}
