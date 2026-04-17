class ShippingRateEntity {
  final String baseZone1;
  final String baseZone2;
  final String baseZone3;
  final String baseZone4;
  final String baseZone5;
  final String additionalZone1;
  final String additionalZone2;
  final String additionalZone3;
  final String additionalZone4;
  final String additionalZone5;
  final String baseWeight;
  final String additionalWeight;
  final int carrierId;
  final String cod;
  final String codPercentage;
  final String category;
  final String logoUrl;
  final String carrierName;
  final String carrierStatus;
  final String providerId;
  final String carrierType;
  final String journeyType;

  const ShippingRateEntity({
    required this.baseZone1,
    required this.baseZone2,
    required this.baseZone3,
    required this.baseZone4,
    required this.baseZone5,
    required this.additionalZone1,
    required this.additionalZone2,
    required this.additionalZone3,
    required this.additionalZone4,
    required this.additionalZone5,
    required this.baseWeight,
    required this.additionalWeight,
    required this.carrierId,
    required this.cod,
    required this.codPercentage,
    required this.category,
    required this.logoUrl,
    required this.carrierName,
    required this.carrierStatus,
    required this.providerId,
    required this.carrierType,
    required this.journeyType,
  });
}
