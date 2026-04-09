import 'order_entity.dart';

class OrdersResponseEntity {
  final int totalCount;
  final List<OrderEntity> orders;

  OrdersResponseEntity({
    required this.totalCount,
    required this.orders,
  });
}
