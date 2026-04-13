import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

class CancelOrdersUseCase {
  final OrdersRepository _repository;

  CancelOrdersUseCase(this._repository);

  Future<void> execute(List<int> orderIds) async {
    await _repository.cancelOrders(orderIds);
  }
}
