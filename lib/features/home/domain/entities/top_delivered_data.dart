import 'package:equatable/equatable.dart';

class TopDeliveredData extends Equatable {
  final List<DeliveredPincodeCount> topDeliveredPincode;
  final List<DeliveredCityCount> topDeliveredCity;
  final List<DeliveredStateCount> topDeliveredState;
  final List<DeliveredCourierCount> topDeliveredCourier;

  const TopDeliveredData({
    required this.topDeliveredPincode,
    required this.topDeliveredCity,
    required this.topDeliveredState,
    required this.topDeliveredCourier,
  });

  @override
  List<Object?> get props => [
        topDeliveredPincode,
        topDeliveredCity,
        topDeliveredState,
        topDeliveredCourier,
      ];
}

class DeliveredPincodeCount extends Equatable {
  final String pin;
  final int count;
  final double percentage;

  const DeliveredPincodeCount({
    required this.pin,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [pin, count, percentage];
}

class DeliveredCityCount extends Equatable {
  final String city;
  final int count;
  final double percentage;

  const DeliveredCityCount({
    required this.city,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [city, count, percentage];
}

class DeliveredStateCount extends Equatable {
  final String state;
  final int count;
  final double percentage;

  const DeliveredStateCount({
    required this.state,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [state, count, percentage];
}

class DeliveredCourierCount extends Equatable {
  final String carrier;
  final int count;
  final double percentage;

  const DeliveredCourierCount({
    required this.carrier,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [carrier, count, percentage];
}
