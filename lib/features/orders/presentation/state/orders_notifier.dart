import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/filters_tab_provider.dart';
import 'orders_provider.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/entities/orders_response_entity.dart';
import 'orders_tab_provider.dart';

part 'orders_notifier.g.dart';

class OrdersState {
  final OrdersResponseEntity? data;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isFiltering;
  final Object? error;

  OrdersState({
    this.data,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isFiltering = false,
    this.error,
  });

  OrdersState copyWith({
    OrdersResponseEntity? data,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isFiltering,
    Object? error,
  }) {
    return OrdersState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFiltering: isFiltering ?? this.isFiltering,
      error: error,
    );
  }
}

@riverpod
class OrdersNotifier extends _$OrdersNotifier {
  @override
  Future<OrdersState> build(int tabIndex) async {
    final channel = ref.read(orderChannelFilterProvider);
    final serviceType = ref.read(orderCourierServiceTypeFilterProvider);
    final pickupAddressId = ref.read(orderPickupAddressFilterProvider);
    final dashboardDate = ref.watch(dashboardDateProvider);
    final paymentType = ref.read(orderPaymentTypeFilterProvider);
    final whatsappRemark = ref.read(orderWhatsappConfirmationFilterProvider);
    final params = OrderListParams(
      startDate: dashboardDate.start,
      endDate: dashboardDate.end,
      skip: 0,
      total: 10,
      status: tabIndex == 0 ? 'TO_BE_PROCESSED' : null,
      isFailed: tabIndex == 1 ? "true" : null,
      channel: channel == "All" ? null : channel,
      serviceType: serviceType == null || serviceType == "All"
          ? null
          : [serviceType],
      pickupAddressId: pickupAddressId == null
          ? null
          : int.parse(pickupAddressId),
      paymentType: paymentType,
      whatsappRemark: whatsappRemark,
    );

    final response = await _fetchOrders(params);

    return OrdersState(data: response);
  }

  Future<OrdersResponseEntity> _fetchOrders(OrderListParams params) async {
    return ref.read(getOrdersUseCaseProvider).execute(params);
  }

  Future<void> applyFilters() async {
    final current = state.value;
    if (current == null) return;

    // ✅ Overlay loading (keep old data)
    state = AsyncData(current.copyWith(isFiltering: true));

    try {
      final params = _buildParams();
      final response = await _fetchOrders(params);

      state = AsyncData(OrdersState(data: response));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || current.data == null) return;

    final totalCount = current.data!.totalCount;
    final currentCount = current.data!.orders.length;

    if (currentCount >= totalCount) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final params = _buildParams().copyWith(
        skip: currentCount,
        total: 10,
      );

      final newResponse = await _fetchOrders(params);

      final updated = OrdersResponseEntity(
        totalCount: newResponse.totalCount,
        orders: [...current.data!.orders, ...newResponse.orders],
      );

      state = AsyncData(current.copyWith(data: updated, isLoadingMore: false));
    } catch (e, st) {
      state = AsyncData(current.copyWith(isLoadingMore: false, error: e));
    }
  }

  OrderListParams _buildParams() {
    final channel = ref.read(orderChannelFilterProvider);
    final serviceType = ref.read(orderCourierServiceTypeFilterProvider);
    final pickupAddressId = ref.read(orderPickupAddressFilterProvider);
    final selectedTab = ref.read(ordersTabProvider);
    final dashboardDate = ref.read(dashboardDateProvider);
    final paymentType = ref.read(orderPaymentTypeFilterProvider);
    final whatsappRemark = ref.read(orderWhatsappConfirmationFilterProvider);
    return OrderListParams(
      startDate: dashboardDate.start,
      endDate: dashboardDate.end,
      skip: 0,
      total: 10,
      status: selectedTab == 0 ? 'TO_BE_PROCESSED' : null,
      isFailed: selectedTab == 1 ? "true" : null,
      channel: channel == "All" ? null : channel,
      serviceType: serviceType == null || serviceType == "All"
          ? null
          : [serviceType],
      pickupAddressId: pickupAddressId == null
          ? null
          : int.parse(pickupAddressId),
      paymentType: paymentType,
      whatsappRemark: whatsappRemark,
    );
  }
}
