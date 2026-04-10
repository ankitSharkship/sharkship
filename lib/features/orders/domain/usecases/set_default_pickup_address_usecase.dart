import '../repositories/orders_repository.dart';

class SetDefaultPickupAddressUseCase {
  final OrdersRepository repository;

  SetDefaultPickupAddressUseCase(this.repository);

  Future<bool> execute(int id) {
    return repository.setDefaultPickupAddress(id);
  }
}
