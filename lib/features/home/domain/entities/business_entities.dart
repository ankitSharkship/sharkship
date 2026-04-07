import 'package:equatable/equatable.dart';

class BusinessOverviewCount extends Equatable {
  final DateTime date;
  final int count;

  const BusinessOverviewCount({
    required this.date,
    required this.count,
  });

  @override
  List<Object?> get props => [date, count];
}

class StateStatusCount extends Equatable {
  final String status;
  final int count;
  final String state;

  const StateStatusCount({
    required this.status,
    required this.count,
    required this.state,
  });

  @override
  List<Object?> get props => [status, count, state];
}

class ZonePercentageCount extends Equatable {
  final String zone;
  final int count;

  const ZonePercentageCount({
    required this.zone,
    required this.count,
  });

  @override
  List<Object?> get props => [zone, count];
}
