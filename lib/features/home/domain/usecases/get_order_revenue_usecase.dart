import '../entities/order_revenue.dart';
import '../repositories/dashboard_repository.dart';

class GetOrderRevenueUseCase {
  final DashboardRepository repository;

  GetOrderRevenueUseCase(this.repository);

  Future<OrderRevenue> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getOrderRevenue(startDate: startDate, endDate: endDate);
  }
}
