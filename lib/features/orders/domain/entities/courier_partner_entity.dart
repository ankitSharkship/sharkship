class CourierPartnerEntity {
  final int carrierId;
  final String carrier;
  final String courierType;
  final String? logoUrl;
  final String baseWeight;
  final String additionalWeight;
  final String serviceType;

  CourierPartnerEntity({
    required this.carrierId,
    required this.carrier,
    required this.courierType,
    this.logoUrl,
    required this.baseWeight,
    required this.additionalWeight,
    required this.serviceType,
  });
}
