import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/orders/domain/entities/orders_response_entity.dart';
import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';

part 'shipment_notifier.g.dart';

@riverpod
class ShipmentNotifier extends _$ShipmentNotifier {
  @override
  FutureOr<OrdersResponseEntity> build(int tabIndex) {
    final dashboardDate = ref.watch(dashboardDateProvider);
    final startDate = dashboardDate.start;
    final endDate = dashboardDate.end;
    return _fetchOrders(
      OrderListParams(
        startDate: startDate,
        endDate: endDate,
        channel: "",
        carrier: "",
        status: getStatus(tabIndex),
        paymentType: "",
      ),
    );
  }

  String getStatus(int tab) {
    switch (tab) {
      case 0:
        return "PROCESSED";
      case 1:
        return "SHIPPED";
      case 2:
        return "OUT_FOR_DELIVERY";
      case 3:
        return "DELIVERED";
      case 4:
        return "RETURNED";
      case 5:
        return "CANCELLED";
      default:
        return "ALL";
    }
  }

  Future<OrdersResponseEntity> _fetchOrders(OrderListParams params) async {
    return ref.read(getOrdersUseCaseProvider).execute(params);
  }

  Future<void> updateFilters(OrderListParams params) async {
    state = await AsyncValue.guard(() => _fetchOrders(params));
  }
}
