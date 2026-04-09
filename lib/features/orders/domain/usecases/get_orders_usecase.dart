import '../repositories/orders_repository.dart';
import '../entities/orders_response_entity.dart';

class GetOrdersUseCase {
  final OrdersRepository repository;

  GetOrdersUseCase(this.repository);

  Future<OrdersResponseEntity> execute(OrderListParams params) {
    return repository.getOrders(params);
  }
}
