import '../repositories/orders_repository.dart';
import '../entities/courier_rate_entity.dart';

class GetShippingRatesUseCase {
  final OrdersRepository repository;

  GetShippingRatesUseCase(this.repository);

  Future<ShippingRateResponseEntity> execute(ShippingRateParams params) {
    return repository.getShippingRates(params);
  }
}
