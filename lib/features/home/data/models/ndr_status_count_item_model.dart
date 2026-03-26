import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/ndr_status_count_item.dart';

part 'ndr_status_count_item_model.g.dart';

@JsonSerializable()
class NdrStatusCountItemModel extends NdrStatusCountItem {
  const NdrStatusCountItemModel({
    required bool isNdr,
    @JsonKey(fromJson: _countFromJson)
    required int count,
  }) : super(
          isNdr: isNdr,
          count: count,
        );

  factory NdrStatusCountItemModel.fromJson(Map<String, dynamic> json) =>
      _$NdrStatusCountItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$NdrStatusCountItemModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}
