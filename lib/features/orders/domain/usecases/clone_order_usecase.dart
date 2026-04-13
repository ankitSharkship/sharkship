import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

class CloneOrderUseCase {
  final OrdersRepository _repository;

  CloneOrderUseCase(this._repository);

  Future<void> execute(int id) async {
    await _repository.cloneOrder(id);
  }
}
