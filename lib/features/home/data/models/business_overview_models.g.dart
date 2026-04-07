// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_overview_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessOverviewModel _$BusinessOverviewModelFromJson(
  Map<String, dynamic> json,
) => BusinessOverviewModel(
  date: DateTime.parse(json['date'] as String),
  count: BusinessOverviewModel._countFromJson(json['count']),
);

Map<String, dynamic> _$BusinessOverviewModelToJson(
  BusinessOverviewModel instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'count': instance.count,
};

StateStatusCountModel _$StateStatusCountModelFromJson(
  Map<String, dynamic> json,
) => StateStatusCountModel(
  status: json['status'] as String,
  count: StateStatusCountModel._countFromJson(json['count']),
  state: json['state'] as String,
);

Map<String, dynamic> _$StateStatusCountModelToJson(
  StateStatusCountModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'count': instance.count,
  'state': instance.state,
};

ZoneCountModel _$ZoneCountModelFromJson(Map<String, dynamic> json) =>
    ZoneCountModel(
      zone: json['zone'] as String,
      count: ZoneCountModel._countFromJson(json['count']),
    );

Map<String, dynamic> _$ZoneCountModelToJson(ZoneCountModel instance) =>
    <String, dynamic>{'zone': instance.zone, 'count': instance.count};
