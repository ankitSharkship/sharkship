import '../repositories/orders_repository.dart';

class EditOrderUseCase {
  final OrdersRepository repository;

  EditOrderUseCase(this.repository);

  Future<Map<String, dynamic>> execute(int id, Map<String, dynamic> data) {
    return repository.editOrder(id, data);
  }
}
