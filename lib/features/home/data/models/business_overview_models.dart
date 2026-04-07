import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/business_entities.dart';

part 'business_overview_models.g.dart';

@JsonSerializable()
class BusinessOverviewModel extends BusinessOverviewCount {
  @override
  final DateTime date;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  const BusinessOverviewModel({
    required this.date,
    required this.count,
  }) : super(date: date, count: count);

  factory BusinessOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessOverviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessOverviewModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}

@JsonSerializable()
class StateStatusCountModel extends StateStatusCount {
  @override
  final String status;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  final String state;

  const StateStatusCountModel({
    required this.status,
    required this.count,
    required this.state,
  }) : super(status: status, count: count, state: state);

  factory StateStatusCountModel.fromJson(Map<String, dynamic> json) =>
      _$StateStatusCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$StateStatusCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}

@JsonSerializable()
class ZoneCountModel extends ZonePercentageCount {
  @override
  final String zone;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  const ZoneCountModel({
    required this.zone,
    required this.count,
  }) : super(zone: zone, count: count);

  factory ZoneCountModel.fromJson(Map<String, dynamic> json) =>
      _$ZoneCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}
