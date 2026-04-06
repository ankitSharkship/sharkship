import 'package:equatable/equatable.dart';

class NdrData extends Equatable {
  final List<NdrZoneCount> ndrDataByZone;
  final List<NdrCourierCount> ndrDataByCourier;

  const NdrData({
    required this.ndrDataByZone,
    required this.ndrDataByCourier,
  });

  @override
  List<Object?> get props => [ndrDataByZone, ndrDataByCourier];
}

class NdrZoneCount extends Equatable {
  final String zone;
  final int count;

  const NdrZoneCount({
    required this.zone,
    required this.count,
  });

  @override
  List<Object?> get props => [zone, count];
}

class NdrCourierCount extends Equatable {
  final String carrier;
  final int count;

  const NdrCourierCount({
    required this.carrier,
    required this.count,
  });

  @override
  List<Object?> get props => [carrier, count];
}
