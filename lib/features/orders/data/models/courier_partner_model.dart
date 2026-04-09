import '../../domain/entities/courier_partner_entity.dart';

class CourierPartnerModel extends CourierPartnerEntity {
  CourierPartnerModel({
    required super.carrierId,
    required super.carrier,
    required super.courierType,
    super.logoUrl,
    required super.baseWeight,
    required super.additionalWeight,
    required super.serviceType,
  });

  factory CourierPartnerModel.fromJson(Map<String, dynamic> json) {
    return CourierPartnerModel(
      carrierId: json['carrierId'],
      carrier: json['carrier'],
      courierType: json['courier_type'],
      logoUrl: json['logo_url'],
      baseWeight: json['base_weight'],
      additionalWeight: json['additional_weight'],
      serviceType: json['service_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carrierId': carrierId,
      'carrier': carrier,
      'courier_type': courierType,
      'logo_url': logoUrl,
      'base_weight': baseWeight,
      'additional_weight': additionalWeight,
      'service_type': serviceType,
    };
  }
}
