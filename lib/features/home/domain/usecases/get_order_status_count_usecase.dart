import '../entities/order_status_summary.dart';
import '../repositories/dashboard_repository.dart';

class GetOrderStatusCountUseCase {
  final DashboardRepository repository;

  GetOrderStatusCountUseCase(this.repository);

  Future<OrderStatusSummary> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getOrderStatusCount(startDate: startDate, endDate: endDate);
  }
}
