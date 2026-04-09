import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

class DeleteOrdersUsecase {
  final OrdersRepository repo;
  const DeleteOrdersUsecase(this.repo);

  Future<Map<String, dynamic>> execute(Map<String, dynamic> orderIds) async {
    return await repo.deleteOrders(orderIds);
  }
}
