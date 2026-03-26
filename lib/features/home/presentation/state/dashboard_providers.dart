import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/domain/usecases/get_order_status_count_usecase.dart';
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
