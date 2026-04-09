class CourierRateEntity {
  final String id;
  final String carrier;
  final int carrierId;
  final String courierType;
  final num baseWeight;
  final String serviceType;
  final num additionalWeight;
  final num rate;
  final num cod;
  final String? logo;
  final String provider;

  CourierRateEntity({
    required this.id,
    required this.carrier,
    required this.carrierId,
    required this.courierType,
    required this.baseWeight,
    required this.serviceType,
    required this.additionalWeight,
    required this.rate,
    required this.cod,
    this.logo,
    required this.provider,
  });
}

class ShippingRateResponseEntity {
  final List<CourierRateEntity> rates;
  final ShippingLocationEntity source;
  final ShippingLocationEntity destination;
  final String zone;

  ShippingRateResponseEntity({
    required this.rates,
    required this.source,
    required this.destination,
    required this.zone,
  });
}

class ShippingLocationEntity {
  final String? city;
  final String? state;

  ShippingLocationEntity({
    this.city,
    this.state,
  });
}
