import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import '../../data/datasources/finance_datasource.dart';
import '../../data/repositories/finance_repository_impl.dart';
import '../../domain/repositories/finance_repository.dart';
import '../../domain/usecases/get_shipping_rates_usecase.dart';
import '../../domain/usecases/calculate_shipping_rate_usecase.dart';

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
