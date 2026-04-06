// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datewise_rto_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatewiseRtoCountModel _$DatewiseRtoCountModelFromJson(
  Map<String, dynamic> json,
) => DatewiseRtoCountModel(
  date: DateTime.parse(json['date'] as String),
  count: DatewiseRtoCountModel._countFromJson(json['rtoCount']),
);

Map<String, dynamic> _$DatewiseRtoCountModelToJson(
  DatewiseRtoCountModel instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'rtoCount': instance.count,
};
