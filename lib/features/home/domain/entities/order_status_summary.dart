import 'package:equatable/equatable.dart';
import 'package:sharkship/features/home/domain/entities/order_status_count.dart';

class OrderStatusSummary extends Equatable {
  final List<OrderStatusCountItem> toBeProcessedAndReadyToShip;
  final List<OrderStatusCountItem> otherOrders;

  const OrderStatusSummary({
    required this.toBeProcessedAndReadyToShip,
    required this.otherOrders,
  });

  /// Helper to get count by status string
  int getStatusCount(String status) {
    for (final item in toBeProcessedAndReadyToShip) {
      if (item.status == status) return item.count;
    }
    for (final item in otherOrders) {
      if (item.status == status) return item.count;
    }
    return 0;
  }

  @override
  List<Object?> get props => [toBeProcessedAndReadyToShip, otherOrders];
}
