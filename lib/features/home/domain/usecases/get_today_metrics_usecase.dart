import '../entities/today_metrics.dart';
import '../repositories/dashboard_repository.dart';

class GetTodayMetricsUseCase {
  final DashboardRepository repository;

  GetTodayMetricsUseCase(this.repository);

  Future<TodayMetrics> call() async {
    return await repository.getTodayMetrics();
  }
}
