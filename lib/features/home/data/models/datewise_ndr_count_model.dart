import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/datewise_ndr_count.dart';

part 'datewise_ndr_count_model.g.dart';

@JsonSerializable()
class DatewiseNdrCountModel extends DatewiseNdrCount {
  @override
  final DateTime date;

  @override
  @JsonKey(name: 'ndrCount', fromJson: _countFromJson)
  final int count;

  const DatewiseNdrCountModel({
    required this.date,
    required this.count,
  }) : super(
          date: date,
          count: count,
        );

  factory DatewiseNdrCountModel.fromJson(Map<String, dynamic> json) =>
      _$DatewiseNdrCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DatewiseNdrCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}
