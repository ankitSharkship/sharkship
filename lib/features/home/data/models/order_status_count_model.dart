import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_status_count.dart';

part 'order_status_count_model.g.dart';

@JsonSerializable()
class OrderStatusCountItemModel extends OrderStatusCountItem {
  const OrderStatusCountItemModel({
    required String status,
    @JsonKey(fromJson: _countFromJson) required int count,
  }) : super(
          status: status,
          count: count,
        );

  factory OrderStatusCountItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusCountItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusCountItemModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}