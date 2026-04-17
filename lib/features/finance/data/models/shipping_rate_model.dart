import '../../domain/entities/shipping_rate_entity.dart';

class ShippingRateModel extends ShippingRateEntity {
  const ShippingRateModel({
    required super.baseZone1,
    required super.baseZone2,
    required super.baseZone3,
    required super.baseZone4,
    required super.baseZone5,
    required super.additionalZone1,
    required super.additionalZone2,
    required super.additionalZone3,
    required super.additionalZone4,
    required super.additionalZone5,
    required super.baseWeight,
    required super.additionalWeight,
    required super.carrierId,
    required super.cod,
    required super.codPercentage,
    required super.category,
    required super.logoUrl,
    required super.carrierName,
    required super.carrierStatus,
    required super.providerId,
    required super.carrierType,
    required super.journeyType,
  });

  factory ShippingRateModel.fromJson(Map<String, dynamic> json) {
    return ShippingRateModel(
      baseZone1: json['base_zone1']?.toString() ?? '0.00',
      baseZone2: json['base_zone2']?.toString() ?? '0.00',
      baseZone3: json['base_zone3']?.toString() ?? '0.00',
      baseZone4: json['base_zone4']?.toString() ?? '0.00',
      baseZone5: json['base_zone5']?.toString() ?? '0.00',
      additionalZone1: json['additional_zone1']?.toString() ?? '0.00',
      additionalZone2: json['additional_zone2']?.toString() ?? '0.00',
      additionalZone3: json['additional_zone3']?.toString() ?? '0.00',
      additionalZone4: json['additional_zone4']?.toString() ?? '0.00',
      additionalZone5: json['additional_zone5']?.toString() ?? '0.00',
      baseWeight: json['base_weight']?.toString() ?? '0.00',
      additionalWeight: json['additional_weight']?.toString() ?? '0.00',
      carrierId: json['carrierId'] ?? 0,
      cod: json['cod']?.toString() ?? '0.00',
      codPercentage: json['cod_percentage']?.toString() ?? '0.00',
      category: json['category'] ?? '',
      logoUrl: json['logo_url'] ?? '',
      carrierName: json['carrier_name'] ?? '',
      carrierStatus: json['carrier_status'] ?? '',
      providerId: json['providerid'] ?? '',
      carrierType: json['carrier_type'] ?? '',
      journeyType: json['journey_type'] ?? '',
    );
  }
}
