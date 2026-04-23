import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/entities/message_metrics_entity.dart';
import 'package:sharkship/features/finance/domain/entities/message_transaction_entity.dart';
import 'package:sharkship/features/finance/domain/entities/remittance_entity.dart';
import 'package:sharkship/features/finance/domain/entities/shipping_rate_entity.dart';
import 'package:sharkship/features/finance/domain/entities/calculator_rate_entity.dart';
import 'package:sharkship/features/finance/domain/entities/transaction_entity.dart';
import 'package:sharkship/features/finance/domain/repositories/finance_repository.dart';
import 'package:sharkship/features/finance/data/datasources/finance_datasource.dart';
import 'package:sharkship/features/finance/data/models/remittance_model.dart';
import 'package:sharkship/features/finance/data/models/message_transaction_model.dart';
import 'package:sharkship/features/finance/presentation/state/transactions_notifier.dart';

part 'finance_repository_impl.g.dart';

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
  Future<Either<Failure, MessageTransactionsResponse>> getMessageTransactions(
      TransactionsParams params) async {
    try {
      final model = await _dataSource.getMessageTransactions(
        take: params.total,
        skip: params.skip,
        startDate: params.startDate,
        endDate: params.endDate,
      );
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RemittanceDetails>> getRemittanceDetails() async {
    try {
      final response = await _dataSource.getRemittanceDetails();
      final model = RemittanceDetailsModel.fromJson(
          response['remittanceDetails'] as Map<String, dynamic>);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      final response = await _dataSource.getRemittanceCycles(
        total: total,
        skip: skip,
        startDate: startDate,
        endDate: endDate,
        status: status,
        businessName: businessName,
        remittanceId: remittanceId,
        userId: userId,
        phone: phone,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

@riverpod
FinanceRepository financeRepository(Ref ref) {
  final dataSource = ref.watch(financeDataSourceProvider);
  return FinanceRepositoryImpl(dataSource);
}
