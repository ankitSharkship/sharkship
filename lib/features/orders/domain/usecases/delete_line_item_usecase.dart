import '../repositories/orders_repository.dart';

class DeleteLineItemUseCase {
  final OrdersRepository repository;

  DeleteLineItemUseCase(this.repository);

  Future<bool> execute(int id) {
    return repository.deleteLineItem(id);
  }
}
