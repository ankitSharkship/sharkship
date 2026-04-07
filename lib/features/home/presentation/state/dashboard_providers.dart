import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/features/home/domain/usecases/get_carrier_pickup_data_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_today_metrics_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_ndr_data_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_datewise_ndr_count_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_top_rto_data_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_datewise_rto_count_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_top_delivered_data_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_cod_data_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_order_revenue_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_remittance_overview_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/business_overview_usecases.dart';
import 'package:sharkship/features/home/domain/usecases/get_ndr_status_count_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_order_status_count_usecase.dart';
import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';

final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  return DashboardRemoteDataSourceImpl(ref.watch(dioClientProvider).dio);
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    remoteDataSource: ref.watch(dashboardRemoteDataSourceProvider),
  );
});

final getTodayMetricsUseCaseProvider = Provider<GetTodayMetricsUseCase>((ref) {
  return GetTodayMetricsUseCase(ref.watch(dashboardRepositoryProvider));
});

final getOrderStatusSummaryUseCaseProvider =
    Provider<GetOrderStatusCountUseCase>((ref) {
  return GetOrderStatusCountUseCase(ref.watch(dashboardRepositoryProvider));
});

final getNdrStatusSummaryUseCaseProvider =
    Provider<GetNdrStatusCountUsecase>((ref) {
  return GetNdrStatusCountUsecase(ref.watch(dashboardRepositoryProvider));
});

final getCarrierPickupDataUseCaseProvider =
    Provider<GetCarrierPickupDataUsecase>((ref) {
  return GetCarrierPickupDataUsecase(ref.watch(dashboardRepositoryProvider));
});

final getNdrDataUseCaseProvider = Provider<GetNdrDataUseCase>((ref) {
  return GetNdrDataUseCase(ref.watch(dashboardRepositoryProvider));
});

final getDatewiseNdrCountUseCaseProvider = Provider<GetDatewiseNdrCountUseCase>((ref) {
  return GetDatewiseNdrCountUseCase(ref.watch(dashboardRepositoryProvider));
});

final getTopRtoDataUseCaseProvider = Provider<GetTopRtoDataUseCase>((ref) {
  return GetTopRtoDataUseCase(ref.watch(dashboardRepositoryProvider));
});

final getDatewiseRtoCountUseCaseProvider = Provider<GetDatewiseRtoCountUseCase>((ref) {
  return GetDatewiseRtoCountUseCase(ref.watch(dashboardRepositoryProvider));
});

final getTopDeliveredDataUseCaseProvider = Provider<GetTopDeliveredDataUseCase>((ref) {
  return GetTopDeliveredDataUseCase(ref.watch(dashboardRepositoryProvider));
});

final getCodDataUseCaseProvider = Provider<GetCodDataUseCase>((ref) {
  return GetCodDataUseCase(ref.watch(dashboardRepositoryProvider));
});

final getOrderRevenueUseCaseProvider = Provider<GetOrderRevenueUseCase>((ref) {
  return GetOrderRevenueUseCase(ref.watch(dashboardRepositoryProvider));
});

final getRemittanceOverviewUseCaseProvider =
    Provider<GetRemittanceOverviewUseCase>((ref) {
  return GetRemittanceOverviewUseCase(ref.watch(dashboardRepositoryProvider));
});

final getBusinessOverviewUseCaseProvider = Provider<GetBusinessOverviewUseCase>((ref) {
  return GetBusinessOverviewUseCase(ref.watch(dashboardRepositoryProvider));
});

final getMapOrdersUseCaseProvider = Provider<GetMapOrdersUseCase>((ref) {
  return GetMapOrdersUseCase(ref.watch(dashboardRepositoryProvider));
});

final getZoneDistributionUseCaseProvider = Provider<GetZoneDistributionUseCase>((ref) {
  return GetZoneDistributionUseCase(ref.watch(dashboardRepositoryProvider));
});
