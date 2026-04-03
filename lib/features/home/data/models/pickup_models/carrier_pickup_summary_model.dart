import 'package:json_annotation/json_annotation.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary.dart';

import 'pickup_status_model.dart';

part 'carrier_pickup_summary_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CarrierPickupSummaryModel extends CarrierPickupSummary {
  @override
  final String carrier;

  @override
  @JsonKey(name: 'pickup_pending')
  final PickupStatusModel pickupPending;

  @override
  @JsonKey(name: 'pickup_scheduled_tomorrow')
  final PickupStatusModel pickupScheduledTomorrow;

  @override
  @JsonKey(name: 'pickup_done')
  final PickupStatusModel pickupDone;

  @override
  @JsonKey(name: 'pickup_rescheduled')
  final PickupStatusModel pickupRescheduled;

  const CarrierPickupSummaryModel({
    required this.carrier,
    required this.pickupPending,
    required this.pickupScheduledTomorrow,
    required this.pickupDone,
    required this.pickupRescheduled,
  }) : super(
          carrier: carrier,
          pickupPending: pickupPending,
          pickupScheduledTomorrow: pickupScheduledTomorrow,
          pickupDone: pickupDone,
          pickupRescheduled: pickupRescheduled,
        );

  factory CarrierPickupSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$CarrierPickupSummaryModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CarrierPickupSummaryModelToJson(this);
}