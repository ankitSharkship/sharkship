// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickupStatusModel _$PickupStatusModelFromJson(Map<String, dynamic> json) =>
    PickupStatusModel(
      count: (json['count'] as num).toInt(),
      orderIds: (json['orderId'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PickupStatusModelToJson(PickupStatusModel instance) =>
    <String, dynamic>{'count': instance.count, 'orderId': instance.orderIds};
