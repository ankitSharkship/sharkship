import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/today_metrics.dart';

part 'today_metrics_model.g.dart';

@JsonSerializable()
class TodayMetricsModel extends TodayMetrics {
  const TodayMetricsModel({
    required super.todayOrderCount,
    required super.yesterdayOrderCount,
    super.todayRevenue,
    super.yesterdayRevenue,
  });

  factory TodayMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$TodayMetricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodayMetricsModelToJson(this);
}
