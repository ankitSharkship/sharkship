import '../repositories/orders_repository.dart';

class ExportOrdersUseCase {
  final OrdersRepository _repository;

  ExportOrdersUseCase(this._repository);

  Future<void> execute(List<int> orderIds) {
    return _repository.exportOrders(orderIds);
  }
}
