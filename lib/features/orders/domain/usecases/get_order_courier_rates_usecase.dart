import '../repositories/orders_repository.dart';
import '../entities/courier_rate_entity.dart';

class GetOrderCourierRatesUseCase {
  final OrdersRepository repository;

  GetOrderCourierRatesUseCase(this.repository);

  Future<OrderCourierRatesEntity> execute(OrderCourierRatesParams params) {
    return repository.getOrderCourierRates(params);
  }
}
