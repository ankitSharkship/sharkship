import '../../domain/entities/shipping_rate_entity.dart';
import '../../domain/entities/calculator_rate_entity.dart';
import '../../domain/repositories/finance_repository.dart';
import '../datasources/finance_datasource.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final FinanceDataSource _dataSource;

  FinanceRepositoryImpl(this._dataSource);

  @override
  Future<List<ShippingRateEntity>> getShippingRates({
    required String serviceType,
  }) {
    return _dataSource.getShippingRates(serviceType: serviceType);
  }

  @override
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
  }) {
    return _dataSource.calculateShippingRate(
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
