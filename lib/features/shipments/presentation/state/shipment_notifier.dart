import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/orders/domain/entities/orders_response_entity.dart';
import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_filters_tab_provider.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_tab_provider.dart';

part 'shipment_notifier.g.dart';

class ShipmentState {
  final OrdersResponseEntity? data;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isFiltering;
  final Object? error;

  ShipmentState({
    this.data,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isFiltering = false,
    this.error,
  });

  ShipmentState copyWith({
    OrdersResponseEntity? data,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isFiltering,
    Object? error,
  }) {
    return ShipmentState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFiltering: isFiltering ?? this.isFiltering,
      error: error,
    );
  }
}

@riverpod
class ShipmentNotifier extends _$ShipmentNotifier {
  @override
  Future<ShipmentState> build(int tabIndex) async {
    final channel = ref.read(shipmentChannelFilterProvider);
    final serviceType = ref.read(shipmentCourierServiceTypeFilterProvider);
    final pickupAddressId = ref.read(shipmentPickupAddressFilterProvider);
    final dashboardDate = ref.watch(dashboardDateProvider);
    final paymentType = ref.read(shipmentPaymentTypeFilterProvider);
    final whatsappRemark = ref.read(shipmentWhatsappConfirmationFilterProvider);
    final params = OrderListParams(
      skip: 0,
      total: 10,
      startDate: dashboardDate.start,
      endDate: dashboardDate.end,
      channel: channel == "All" ? null : channel,
      carrier: "",
      status: getStatus(tabIndex),
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
    return ShipmentState(data: response);
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

  Future<void> applyFilters() async {
    final current = state.value;
    if (current == null) return;

    // ✅ Overlay loading (keep old data)
    state = AsyncData(current.copyWith(isFiltering: true));

    try {
      final params = _buildParams();
      final response = await _fetchOrders(params);

      state = AsyncData(ShipmentState(data: response));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  OrderListParams _buildParams() {
    print('()+++++++++++++++++++++++++++++++)');
    final channel = ref.read(shipmentChannelFilterProvider);
    final serviceType = ref.read(shipmentCourierServiceTypeFilterProvider);
    final pickupAddressId = ref.read(shipmentPickupAddressFilterProvider);
    final dashboardDate = ref.read(dashboardDateProvider);
    final selectedTab = ref.read(shipmentTabProvider);
    final paymentType = ref.read(shipmentPaymentTypeFilterProvider);
    final whatsappRemark = ref.read(shipmentWhatsappConfirmationFilterProvider);
    return OrderListParams(
      startDate: dashboardDate.start,
      endDate: dashboardDate.end,
      skip: 0,
      total: 10,
      channel: channel == "All" ? null : channel,
      serviceType: serviceType == null || serviceType == "All"
          ? null
          : [serviceType],
      pickupAddressId: pickupAddressId == null
          ? null
          : int.parse(pickupAddressId),
      paymentType: paymentType,
      status: getStatus(selectedTab),
      whatsappRemark: whatsappRemark,
    );
  }

  Future<void> loadMore() async {
    print('Loading more');
    final current = state.value;
    if (current == null || current.isLoadingMore || current.data == null)
      return;

    final totalCount = current.data!.totalCount;
    final currentCount = current.data!.orders.length;

    if (currentCount >= totalCount) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      print('Loading more started');
      final params = _buildParams().copyWith(skip: currentCount, total: 10);

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
}
