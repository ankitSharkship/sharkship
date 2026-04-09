import '../../domain/repositories/orders_repository.dart';

class CreateOrderUseCase {
  final OrdersRepository repository;

  CreateOrderUseCase(this.repository);

  Future<bool> execute(CreateOrderParams params) async {
    return await repository.createOrder(params);
  }
}
