import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_status_summary.dart';
import 'order_status_count_model.dart';

part 'order_status_summary_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderStatusSummaryModel extends OrderStatusSummary {
  @override
  @JsonKey(name: 'ToBeProcessedAndReadyToShipOrders')
  final List<OrderStatusCountItemModel> toBeProcessedAndReadyToShip;

  @override
  @JsonKey(name: 'allOrdersExceptToBeProcessedAndReadyToShip')
  final List<OrderStatusCountItemModel> otherOrders;

  const OrderStatusSummaryModel({
    required this.toBeProcessedAndReadyToShip,
    required this.otherOrders,
  }) : super(
          toBeProcessedAndReadyToShip: toBeProcessedAndReadyToShip,
          otherOrders: otherOrders,
        );

  factory OrderStatusSummaryModel.fromJson(Map<String, dynamic> json) {
    // API returns the summary inside 'countByStatus'
    final data = json['countByStatus'] as Map<String, dynamic>? ?? {};
    return _$OrderStatusSummaryModelFromJson(data);
  }

  @override
  Map<String, dynamic> toJson() => {
        'countByStatus': _$OrderStatusSummaryModelToJson(this),
      };
}