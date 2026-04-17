class CalculatorRateEntity {
  final String id;
  final String carrier;
  final int carrierId;
  final String courierType;
  final double baseWeight;
  final String serviceType;
  final double additionalWeight;
  final double? rate;
  final double cod;
  final String logo;
  final String provider;

  CalculatorRateEntity({
    required this.id,
    required this.carrier,
    required this.carrierId,
    required this.courierType,
    required this.baseWeight,
    required this.serviceType,
    required this.additionalWeight,
    this.rate,
    required this.cod,
    required this.logo,
    required this.provider,
  });
}
