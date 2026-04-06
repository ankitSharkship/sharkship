import 'package:equatable/equatable.dart';

class TopRtoData extends Equatable {
  final List<RtoPincodeCount> topRtoPincode;
  final List<RtoCityCount> topRtoCity;
  final List<RtoStateCount> topRtoState;
  final List<RtoCourierCount> topRtoCourier;

  const TopRtoData({
    required this.topRtoPincode,
    required this.topRtoCity,
    required this.topRtoState,
    required this.topRtoCourier,
  });

  @override
  List<Object?> get props => [
        topRtoPincode,
        topRtoCity,
        topRtoState,
        topRtoCourier,
      ];
}

class RtoPincodeCount extends Equatable {
  final String pin;
  final int count;
  final double percentage;

  const RtoPincodeCount({
    required this.pin,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [pin, count, percentage];
}

class RtoCityCount extends Equatable {
  final String city;
  final int count;
  final double percentage;

  const RtoCityCount({
    required this.city,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [city, count, percentage];
}

class RtoStateCount extends Equatable {
  final String state;
  final int count;
  final double percentage;

  const RtoStateCount({
    required this.state,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [state, count, percentage];
}

class RtoCourierCount extends Equatable {
  final String carrier;
  final int count;
  final double percentage;

  const RtoCourierCount({
    required this.carrier,
    required this.count,
    required this.percentage,
  });

  @override
  List<Object?> get props => [carrier, count, percentage];
}
