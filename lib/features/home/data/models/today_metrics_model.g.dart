// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_metrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayMetricsModel _$TodayMetricsModelFromJson(Map<String, dynamic> json) =>
    TodayMetricsModel(
      todayOrderCount: (json['todayOrderCount'] as num).toInt(),
      yesterdayOrderCount: (json['yesterdayOrderCount'] as num).toInt(),
      todayRevenue: json['todayRevenue'] as String?,
      yesterdayRevenue: json['yesterdayRevenue'] as String?,
    );

Map<String, dynamic> _$TodayMetricsModelToJson(TodayMetricsModel instance) =>
    <String, dynamic>{
      'todayOrderCount': instance.todayOrderCount,
      'yesterdayOrderCount': instance.yesterdayOrderCount,
      'todayRevenue': instance.todayRevenue,
      'yesterdayRevenue': instance.yesterdayRevenue,
    };
