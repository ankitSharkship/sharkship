import 'package:dio/dio.dart';
import '../models/shipping_rate_model.dart';
import '../models/calculator_rate_model.dart';

class FinanceDataSource {
  final Dio _dio;

  FinanceDataSource(this._dio);

  Future<List<ShippingRateModel>> getShippingRates({
    required String serviceType,
  }) async {
    final response = await _dio.get(
      '/v1/user/shipping-rates',
      queryParameters: {
        'service_type': serviceType,
      },
    );

    final List<dynamic> data = response.data;
    return data.map((json) => ShippingRateModel.fromJson(json)).toList();
  }

  Future<List<CalculatorRateModel>> calculateShippingRate({
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
  }) async {
    final response = await _dio.get(
      '/v1/calculator/shipping-rate',
      queryParameters: {
        'source': source,
        'destination': destination,
        'payment_type': paymentType,
        'weight': weight,
        'productValue': productValue,
      },
      options: Options(
        headers: {
          'length': length,
          'width': width,
          'height': height,
          'service_type': serviceType,
          'provider': provider,
        },
      ),
    );

    final List<dynamic> ratesData = response.data['rates'] as List<dynamic>;
    return ratesData
        .map((json) => CalculatorRateModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
