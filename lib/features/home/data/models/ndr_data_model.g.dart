// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ndr_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NdrDataModel _$NdrDataModelFromJson(Map<String, dynamic> json) => NdrDataModel(
  ndrDataByZone: (json['ndrDataByZone'] as List<dynamic>)
      .map((e) => NdrZoneCountModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  ndrDataByCourier: (json['ndrDataByCourier'] as List<dynamic>)
      .map((e) => NdrCourierCountModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NdrDataModelToJson(
  NdrDataModel instance,
) => <String, dynamic>{
  'ndrDataByZone': instance.ndrDataByZone.map((e) => e.toJson()).toList(),
  'ndrDataByCourier': instance.ndrDataByCourier.map((e) => e.toJson()).toList(),
};

NdrZoneCountModel _$NdrZoneCountModelFromJson(Map<String, dynamic> json) =>
    NdrZoneCountModel(
      zone: json['zone'] as String,
      count: NdrZoneCountModel._countFromJson(json['count']),
    );

Map<String, dynamic> _$NdrZoneCountModelToJson(NdrZoneCountModel instance) =>
    <String, dynamic>{'zone': instance.zone, 'count': instance.count};

NdrCourierCountModel _$NdrCourierCountModelFromJson(
  Map<String, dynamic> json,
) => NdrCourierCountModel(
  carrier: json['carrier'] as String,
  count: NdrCourierCountModel._countFromJson(json['count']),
);

Map<String, dynamic> _$NdrCourierCountModelToJson(
  NdrCourierCountModel instance,
) => <String, dynamic>{'carrier': instance.carrier, 'count': instance.count};
