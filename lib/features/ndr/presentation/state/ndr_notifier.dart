import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_filters_tab_provider.dart';
import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import 'package:sharkship/features/ndr/domain/entity/ndr_response_entity.dart';
import 'ndr_provider.dart';
import 'ndr_tab_provider.dart';

part 'ndr_notifier.g.dart';

class NdrState {
  final NdrResponseEntity? data;
  final bool isLoadingMore;
  final bool isFiltering;
  final Object? error;

  NdrState({
    this.data,
    this.isLoadingMore = false,
    this.isFiltering = false,
    this.error,
  });

  NdrState copyWith({
    NdrResponseEntity? data,
    bool? isLoadingMore,
    bool? isFiltering,
    Object? error,
  }) {
    return NdrState(
      data: data ?? this.data,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFiltering: isFiltering ?? this.isFiltering,
      error: error,
    );
  }
}

@riverpod
class NdrNotifier extends _$NdrNotifier {
  @override
  Future<NdrState> build(int tabIndex) async {
    final dashboardDate = ref.watch(dashboardDateProvider);
    final params = OrderListParams(
      startDate: dashboardDate.start,
      endDate: dashboardDate.end,
      skip: 0,
      total: 10,
      isNdr: 'true',
      status: _getStatus(tabIndex),
    );
    final response = await _fetchOrders(params);
    return NdrState(data: response);
  }

  Future<NdrResponseEntity> _fetchOrders(OrderListParams params) {
    return ref.read(getNdrOrdersUseCaseProvider).execute(params);
  }

  OrderListParams _buildParams(int tab) {
    final tabIndex = tab;
    final dashboardDate = ref.read(dashboardDateProvider);
    final selectedCarrier = ref.read(ndrCarrierFilterProvider);
    final selectedPaymentType = ref.read(ndrPaymentTypeFilterProvider);

    return OrderListParams(
      startDate: dashboardDate.start,
      endDate: dashboardDate.end,
      skip: 0,
      total: 10,
      isNdr: 'true',
      status: _getStatus(tabIndex),
      carrier: selectedCarrier,
      paymentType: selectedPaymentType,
    );
  }

  String _getStatus(int tab) {
    switch (tab) {
      case 0:
        return "NDR";
      case 1:
        return "RE_ATTEMPTED";
      case 2:
        return "DELIVERED";
      case 3:
        return "RETURNED";
      default:
        return "";
    }
  }

  Future<void> applyFilters() async {
    final current = state.value;
    if (current == null) return;

    state = AsyncData(current.copyWith(isFiltering: true));

    try {
      final tab = ref.read(ndrTabProvider);

      final response = await _fetchOrders(_buildParams(tab));
      state = AsyncData(NdrState(data: response));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    final tab = ref.read(ndrTabProvider);
    final current = state.value;
    if (current == null || current.isLoadingMore || current.data == null)
      return;

    final totalCount = current.data!.totalCount;
    final currentCount = current.data!.orders.length;

    if (currentCount >= totalCount) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final params = _buildParams(tab).copyWith(skip: currentCount, total: 10);

      final newResponse = await _fetchOrders(params);

      final updated = NdrResponseEntity(
        totalCount: newResponse.totalCount,
        orders: [...current.data!.orders, ...newResponse.orders],
      );

      state = AsyncData(current.copyWith(data: updated, isLoadingMore: false));
    } catch (e, st) {
      state = AsyncData(current.copyWith(isLoadingMore: false, error: e));
    }
  }
}
