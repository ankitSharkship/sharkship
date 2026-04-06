import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/datewise_rto_count.dart';

part 'datewise_rto_count_model.g.dart';

@JsonSerializable()
class DatewiseRtoCountModel extends DatewiseRtoCount {
  @override
  @JsonKey(name: 'date')
  final DateTime date;

  @override
  @JsonKey(name: 'rtoCount', fromJson: _countFromJson)
  final int count;

  const DatewiseRtoCountModel({
    required this.date,
    required this.count,
  }) : super(
          date: date,
          count: count,
        );

  factory DatewiseRtoCountModel.fromJson(Map<String, dynamic> json) =>
      _$DatewiseRtoCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DatewiseRtoCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}
