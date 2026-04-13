import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'orders_provider.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/entities/orders_response_entity.dart';
import 'orders_tab_provider.dart';

part 'orders_notifier.g.dart';

@riverpod
class OrdersNotifier extends _$OrdersNotifier {
  @override
  FutureOr<OrdersResponseEntity> build(int tabIndex) {
    // Stable dates (once per day) to prevent unnecessary re-fetches
    final dashboardDate = ref.watch(dashboardDateProvider);

    final startDate = dashboardDate.start;
    final endDate = dashboardDate.end;

    return _fetchOrders(
      OrderListParams(
        startDate: startDate,
        endDate: endDate,
        skip: 0,
        total: 10,
        status: tabIndex == 0 ? 'TO_BE_PROCESSED' : null,
        isFailed: tabIndex == 1 ? 'true' : null,
      ),
    );
  }

  Future<OrdersResponseEntity> _fetchOrders(OrderListParams params) async {
    return ref.read(getOrdersUseCaseProvider).execute(params);
  }

  Future<void> updateFilters(OrderListParams params) async {
    state = await AsyncValue.guard(() => _fetchOrders(params));
  }

  Future<void> loadMore(OrderListParams params) async {
    final previousState = state.value;
    if (previousState == null) return;

    state = await AsyncValue.guard(() async {
      final newResponse = await _fetchOrders(params);
      return OrdersResponseEntity(
        totalCount: newResponse.totalCount,
        orders: [...previousState.orders, ...newResponse.orders],
      );
    });
  }

  Future<Map<String, dynamic>> changeShipmentDetails(
    int id,
    Map<String, dynamic> data,
  ) async {
    final result = await ref.read(editOrderUseCaseProvider).execute(id, data);
    return result;
  }
}
