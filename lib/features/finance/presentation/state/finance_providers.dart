import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import '../../data/datasources/finance_datasource.dart';
import '../../data/repositories/finance_repository_impl.dart';
import '../../domain/repositories/finance_repository.dart';
import '../../domain/usecases/get_shipping_rates_usecase.dart';
import '../../domain/usecases/calculate_shipping_rate_usecase.dart';

import '../../domain/usecases/get_transactions_usecase.dart';
import '../../domain/usecases/get_message_metrics_usecase.dart';
import '../../domain/usecases/get_message_transactions_usecase.dart';

import '../../domain/usecases/get_remittance_details_usecase.dart';
import '../../domain/usecases/get_remittance_cycles_usecase.dart';

part 'finance_providers.g.dart';

@riverpod
FinanceDataSource financeDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return FinanceDataSource(dio);
}

@riverpod
FinanceRepository financeRepository(Ref ref) {
  final dataSource = ref.watch(financeDataSourceProvider);
  return FinanceRepositoryImpl(dataSource);
}

@riverpod
GetShippingRatesUseCase getShippingRatesUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetShippingRatesUseCase(repository);
}

@riverpod
CalculateShippingRateUseCase calculateShippingRateUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return CalculateShippingRateUseCase(repository);
}

@riverpod
GetTransactionsUseCase getTransactionsUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetTransactionsUseCase(repository);
}

@riverpod
GetMessageMetricsUseCase getMessageMetricsUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetMessageMetricsUseCase(repository);
}

@riverpod
GetMessageTransactionsUseCase getMessageTransactionsUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetMessageTransactionsUseCase(repository);
}

@riverpod
GetRemittanceDetailsUseCase getRemittanceDetailsUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetRemittanceDetailsUseCase(repository);
}

@riverpod
GetRemittanceCyclesUseCase getRemittanceCyclesUseCase(Ref ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return GetRemittanceCyclesUseCase(repository);
}
