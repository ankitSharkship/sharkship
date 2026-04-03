import 'package:equatable/equatable.dart';
import 'pickup_status.dart';

class CarrierPickupSummary extends Equatable {
  final String carrier;
  final PickupStatus pickupPending;
  final PickupStatus pickupScheduledTomorrow;
  final PickupStatus pickupDone;
  final PickupStatus pickupRescheduled;

  const CarrierPickupSummary({
    required this.carrier,
    required this.pickupPending,
    required this.pickupScheduledTomorrow,
    required this.pickupDone,
    required this.pickupRescheduled,
  });

  @override
  List<Object?> get props => [
        carrier,
        pickupPending,
        pickupScheduledTomorrow,
        pickupDone,
        pickupRescheduled,
      ];
}