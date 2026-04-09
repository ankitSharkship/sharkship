import '../repositories/orders_repository.dart';
import '../entities/order_address_entity.dart';

class GetPickupAddressesUseCase {
  final OrdersRepository repository;

  GetPickupAddressesUseCase(this.repository);

  Future<List<OrderAddressEntity>> execute() {
    return repository.getPickupAddresses();
  }
}
