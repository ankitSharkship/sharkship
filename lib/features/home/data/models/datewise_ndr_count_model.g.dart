// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datewise_ndr_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatewiseNdrCountModel _$DatewiseNdrCountModelFromJson(
  Map<String, dynamic> json,
) => DatewiseNdrCountModel(
  date: DateTime.parse(json['date'] as String),
  count: DatewiseNdrCountModel._countFromJson(json['ndrCount']),
);

Map<String, dynamic> _$DatewiseNdrCountModelToJson(
  DatewiseNdrCountModel instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'ndrCount': instance.count,
};
