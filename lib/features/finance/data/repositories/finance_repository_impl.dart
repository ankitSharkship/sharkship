import 'package:sharkship/features/finance/domain/entities/message_metrics_entity.dart';
import 'package:sharkship/features/finance/domain/entities/message_transaction_entity.dart';

import '../../domain/entities/shipping_rate_entity.dart';
import '../../domain/entities/calculator_rate_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/finance_repository.dart';
import '../datasources/finance_datasource.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final FinanceDataSource _dataSource;

  FinanceRepositoryImpl(this._dataSource);

  @override
  Future<List<ShippingRateEntity>> getShippingRates({
    required String serviceType,
  }) {
    return _dataSource.getShippingRates(serviceType: serviceType);
  }

  @override
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
  }) {
    return _dataSource.calculateShippingRate(
      source: source,
      destination: destination,
      paymentType: paymentType,
      weight: weight,
      productValue: productValue,
      length: length,
      width: width,
      height: height,
      serviceType: serviceType,
      provider: provider,
    );
  }

  @override
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
  }) {
    return _dataSource.getTransactions(
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
      orderId: orderId,
      trackingId: trackingId,
      paymentGatewayId: paymentGatewayId,
    );
  }

  @override
  Future<MessageMetricsEntity> getMessageMetrics({
    required String startDate,
    required String endDate,
  }) {
    return _dataSource.getMessageMetrics(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<MessageTransactionsResponse> getMessageTransactions({
    required int take,
    required int skip,
    required String startDate,
    required String endDate,
  }) {
    return _dataSource.getMessageTransactions(
      take: take,
      skip: skip,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
