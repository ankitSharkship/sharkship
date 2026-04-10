import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

class ShipOrdersUsecase {
  final OrdersRepository repo;
  const ShipOrdersUsecase(this.repo);

  Future<Map<String, dynamic>> execute(Map<String, dynamic> orderIds) async {
    return await repo.shipOrders(orderIds);
  }
}
