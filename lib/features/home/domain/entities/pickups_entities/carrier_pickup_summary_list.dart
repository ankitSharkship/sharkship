import 'package:equatable/equatable.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary.dart';

class CarrierPickupSummaryList extends Equatable {
  final List<CarrierPickupSummary> items;

  const CarrierPickupSummaryList({required this.items});

  @override
  List<Object?> get props => [items];
}