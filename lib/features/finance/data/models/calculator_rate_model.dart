import '../../domain/entities/calculator_rate_entity.dart';

class CalculatorRateModel extends CalculatorRateEntity {
  CalculatorRateModel({
    required super.id,
    required super.carrier,
    required super.carrierId,
    required super.courierType,
    required super.baseWeight,
    required super.serviceType,
    required super.additionalWeight,
    super.rate,
    required super.cod,
    required super.logo,
    required super.provider,
  });

  factory CalculatorRateModel.fromJson(Map<String, dynamic> json) {
    return CalculatorRateModel(
      id: json['id'] as String,
      carrier: json['carrier'] as String,
      carrierId: json['carrierId'] is int
          ? json['carrierId'] as int
          : int.parse(json['carrierId'].toString()),
      courierType: json['courier_type'] as String,
      baseWeight: (json['base_weight'] as num).toDouble(),
      serviceType: json['service_type'] as String,
      additionalWeight: (json['additional_weight'] as num).toDouble(),
      rate: json['rate'] != null ? (json['rate'] as num).toDouble() : null,
      cod: (json['cod'] as num).toDouble(),
      logo: json['logo'] as String? ?? '',
      provider: json['provider'] as String,
    );
  }
}
