import '../../domain/entities/orders_response_entity.dart';
import 'order_model.dart';

class OrdersResponseModel extends OrdersResponseEntity {
  OrdersResponseModel({
    required super.totalCount,
    required List<OrderModel> super.orders,
  });

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) {
    return OrdersResponseModel(
      totalCount: json['totalCount'] ?? 0,
      orders: (json['orders'] as List? ?? [])
          .map((i) => OrderModel.fromJson(i))
          .toList(),
    );
  }
}
