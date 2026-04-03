// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrier_pickup_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarrierPickupSummaryModel _$CarrierPickupSummaryModelFromJson(
  Map<String, dynamic> json,
) => CarrierPickupSummaryModel(
  carrier: json['carrier'] as String,
  pickupPending: PickupStatusModel.fromJson(
    json['pickup_pending'] as Map<String, dynamic>,
  ),
  pickupScheduledTomorrow: PickupStatusModel.fromJson(
    json['pickup_scheduled_tomorrow'] as Map<String, dynamic>,
  ),
  pickupDone: PickupStatusModel.fromJson(
    json['pickup_done'] as Map<String, dynamic>,
  ),
  pickupRescheduled: PickupStatusModel.fromJson(
    json['pickup_rescheduled'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CarrierPickupSummaryModelToJson(
  CarrierPickupSummaryModel instance,
) => <String, dynamic>{
  'carrier': instance.carrier,
  'pickup_pending': instance.pickupPending.toJson(),
  'pickup_scheduled_tomorrow': instance.pickupScheduledTomorrow.toJson(),
  'pickup_done': instance.pickupDone.toJson(),
  'pickup_rescheduled': instance.pickupRescheduled.toJson(),
};
