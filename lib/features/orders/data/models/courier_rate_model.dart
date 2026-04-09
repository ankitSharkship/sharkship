import '../../domain/entities/courier_rate_entity.dart';

class CourierRateModel extends CourierRateEntity {
  CourierRateModel({
    required super.id,
    required super.carrier,
    required super.carrierId,
    required super.courierType,
    required super.baseWeight,
    required super.serviceType,
    required super.additionalWeight,
    required super.rate,
    required super.cod,
    super.logo,
    required super.provider,
  });

  factory CourierRateModel.fromJson(Map<String, dynamic> json) {
    return CourierRateModel(
      id: json['id']?.toString() ?? '',
      carrier: json['carrier']?.toString() ?? '',
      carrierId: json['carrierId'] is int ? json['carrierId'] as int : 0,
      courierType: json['courier_type']?.toString() ?? '',
      baseWeight: json['base_weight'] is num ? json['base_weight'] as num : 0,
      serviceType: json['service_type']?.toString() ?? '',
      additionalWeight: json['additional_weight'] is num ? json['additional_weight'] as num : 0,
      rate: json['rate'] is num ? json['rate'] as num : 0,
      cod: json['cod'] is num ? json['cod'] as num : 0,
      logo: json['logo']?.toString(),
      provider: json['provider']?.toString() ?? '',
    );
  }
}

class ShippingRateResponseModel extends ShippingRateResponseEntity {
  ShippingRateResponseModel({
    required super.rates,
    required super.source,
    required super.destination,
    required super.zone,
  });

  factory ShippingRateResponseModel.fromJson(Map<String, dynamic> json) {
    return ShippingRateResponseModel(
      rates: (json['rates'] as List? ?? [])
          .map((e) => CourierRateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      source: ShippingLocationModel.fromJson(json['source'] ?? {}),
      destination: ShippingLocationModel.fromJson(json['destination'] ?? {}),
      zone: json['zone']?.toString() ?? '',
    );
  }
}

class ShippingLocationModel extends ShippingLocationEntity {
  ShippingLocationModel({
    super.city,
    super.state,
  });

  factory ShippingLocationModel.fromJson(Map<String, dynamic> json) {
    return ShippingLocationModel(
      city: json['city']?.toString(),
      state: json['state']?.toString(),
    );
  }
}
