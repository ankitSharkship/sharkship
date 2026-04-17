import '../entities/shipping_rate_entity.dart';
import '../repositories/finance_repository.dart';

class GetShippingRatesUseCase {
  final FinanceRepository repository;

  GetShippingRatesUseCase(this.repository);

  Future<List<ShippingRateEntity>> execute({
    required String serviceType,
  }) async {
    return await repository.getShippingRates(serviceType: serviceType);
  }
}
