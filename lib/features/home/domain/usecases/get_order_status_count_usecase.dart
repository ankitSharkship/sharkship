import 'package:sharkship/features/home/domain/entities/order_status_summary.dart';
import 'package:sharkship/features/home/domain/repositories/dashboard_repository.dart';

class GetOrderStatusCountUseCase {
  final DashboardRepository repository;
  GetOrderStatusCountUseCase(this.repository);

  Future<OrderStatusSummary> call() async {
    return await repository.getOrderStatusCount();
  }
}
