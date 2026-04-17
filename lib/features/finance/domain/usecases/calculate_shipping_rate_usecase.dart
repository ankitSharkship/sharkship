import '../../domain/entities/calculator_rate_entity.dart';
import '../../domain/repositories/finance_repository.dart';

class CalculateShippingRateUseCase {
  final FinanceRepository _repository;

  CalculateShippingRateUseCase(this._repository);

  Future<List<CalculatorRateEntity>> execute({
    required String source,
    required String destination,
    required String paymentType,
    required double weight,
    required double productValue,
    required double length,
    required double width,
    required double height,
    required String serviceType,
    required String provider,
  }) {
    return _repository.calculateShippingRate(
      source: source,
      destination: destination,
      paymentType: paymentType,
      weight: weight,
      productValue: productValue,
      length: length,
      width: width,
      height: height,
      serviceType: serviceType,
      provider: provider,
    );
  }
}
