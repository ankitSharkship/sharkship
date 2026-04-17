import '../../domain/entities/shipping_rate_entity.dart';
import '../../domain/entities/calculator_rate_entity.dart';

abstract class FinanceRepository {
  Future<List<ShippingRateEntity>> getShippingRates({
    required String serviceType,
  });

  Future<List<CalculatorRateEntity>> calculateShippingRate({
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
  });
}
