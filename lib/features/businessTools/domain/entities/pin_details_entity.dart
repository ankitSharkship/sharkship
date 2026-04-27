import 'package:equatable/equatable.dart';

class PinDetailsEntity extends Equatable {
  final String city;
  final String state;
  final PinLocationEntity? location;

  const PinDetailsEntity({
    required this.city,
    required this.state,
    this.location,
  });

  @override
  List<Object?> get props => [city, state, location];
}

class PinLocationEntity extends Equatable {
  final String lat;
  final String lng;

  const PinLocationEntity({
    required this.lat,
    required this.lng,
  });

  @override
  List<Object?> get props => [lat, lng];
}
