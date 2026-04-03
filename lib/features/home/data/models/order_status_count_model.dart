import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_status_count.dart';

part 'order_status_count_model.g.dart';

@JsonSerializable()
class OrderStatusCountItemModel extends OrderStatusCountItem {
  const OrderStatusCountItemModel({
    required super.status,
    @JsonKey(fromJson: _countFromJson) required super.count,
  });

  factory OrderStatusCountItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusCountItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusCountItemModelToJson(this);

  static String _countFromJson(dynamic value) {
    if (value == null) return '0';
    if (value is String) return value;
    return value.toString();
  }
}
