import 'package:riverpod_annotation/riverpod_annotation.dart';
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
    final nowTime = DateTime.now();
    final now = DateTime(nowTime.year, nowTime.month, nowTime.day, 23, 59, 59);
    final startDate = now.subtract(const Duration(days: 30)).toUtc().toIso8601String();
    final endDate = now.toUtc().toIso8601String();

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
}
