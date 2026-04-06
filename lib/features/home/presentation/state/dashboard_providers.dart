import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/domain/usecases/get_carrier_pickup_data_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_order_status_count_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_ndr_data_usecase.dart';
import 'package:sharkship/features/home/domain/usecases/get_datewise_ndr_count_usecase.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/get_today_metrics_usecase.dart';
import '../../domain/usecases/get_ndr_status_count_usecase.dart';

part 'dashboard_providers.g.dart';

@riverpod
DashboardRemoteDataSource dashboardRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return DashboardRemoteDataSourceImpl(dio);
}

@riverpod
DashboardRepository dashboardRepository(Ref ref) {
  return DashboardRepositoryImpl(
    remoteDataSource: ref.watch(dashboardRemoteDataSourceProvider),
  );
}

@riverpod
class DashboardDate extends _$DashboardDate {
  @override
  DateTimeRange build() {
    final now = DateTime.now();
    return DateTimeRange(
      start: now.subtract(const Duration(days: 7)),
      end: now,
    );
  }

  void updateRange(DateTimeRange range) {
    state = range;
  }
}

@riverpod
GetTodayMetricsUseCase getTodayMetricsUseCase(Ref ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetTodayMetricsUseCase(repository);
}

@riverpod
GetOrderStatusCountUseCase getOrderStatusCountUseCase(Ref ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetOrderStatusCountUseCase(repository);
}

@riverpod
GetNdrStatusCountUsecase getNdrStatusCountUseCase(Ref ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetNdrStatusCountUsecase(repository);
}

@riverpod
GetCarrierPickupDataUsecase getCarrierPickupDataUsecase(Ref ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetCarrierPickupDataUsecase(repository);
}

@riverpod
GetNdrDataUseCase getNdrDataUseCase(Ref ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetNdrDataUseCase(repository);
}

@riverpod
GetDatewiseNdrCountUseCase getDatewiseNdrCountUseCase(Ref ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return GetDatewiseNdrCountUseCase(repository);
}
