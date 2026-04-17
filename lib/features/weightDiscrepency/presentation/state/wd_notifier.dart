import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import 'package:sharkship/features/weightDiscrepency/domain/entities/wd_response_entity.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/state/wd_filters_tab_provider.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/state/wd_providers.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/state/wd_tab_provider.dart';

part 'wd_notifier.g.dart';

class WdState {
  final WdResponseEntity? data;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isFiltering;
  final Object? error;

  WdState({
    this.data,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isFiltering = false,
    this.error,
  });

  WdState copyWith({
    WdResponseEntity? data,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isFiltering,
    Object? error,
  }) {
    return WdState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFiltering: isFiltering ?? this.isFiltering,
      error: error,
    );
  }
}

@riverpod
class WdNotifier extends _$WdNotifier {
  @override
  Future<WdState> build(int tabIndex) async {
    final response = await _fetchDiscrepancies(_buildParams(tabIndex));

    return WdState(data: response);
  }

  String? getStatus(int tab) {
    switch (tab) {
      case 0:
        return "DISPUTED";
      case 1:
        return "PENDING";
      case 2:
        return "COMPLETE";
      case 3:
        return "CANCELLED";
      default:
        return null;
    }
  }

  Future<WdResponseEntity> _fetchDiscrepancies(OrderListParams params) async {
    return ref.read(getWdUsecaseProvider).execute(params);
  }

  OrderListParams _buildParams(int tab) {
    final tabIndex = tab;
    final dashboardDate = ref.read(dashboardDateProvider);
    final selectedCarrier = ref.read(wdCarrierFilterProvider);
    final selectedPaymentType = ref.read(wdPaymentTypeFilterProvider);

    return OrderListParams(
      startDate: dashboardDate.start,
      endDate: dashboardDate.end,
      skip: 0,
      total: 10,
      status: getStatus(tabIndex),
      carrier: selectedCarrier,
      paymentType: selectedPaymentType,
    );
  }

  Future<void> applyFilters() async {
    final current = state.value;
    if (current == null) return;

    state = AsyncData(current.copyWith(isFiltering: true));

    try {
      final selectedTab = ref.read(wdTabProvider);

      final response = await _fetchDiscrepancies(_buildParams(selectedTab));

      state = AsyncData(WdState(data: response));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || current.data == null)
      return;

    final totalCount = current.data!.totalCount;
    final currentCount = current.data!.items.length;

    if (currentCount >= totalCount) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final selectedTab = ref.read(wdTabProvider);

      final newResponse = await _fetchDiscrepancies(_buildParams(selectedTab));

      final updated = WdResponseEntity(
        totalCount: newResponse.totalCount,
        items: [...current.data!.items, ...newResponse.items],
      );

      state = AsyncData(current.copyWith(data: updated, isLoadingMore: false));
    } catch (e, st) {
      state = AsyncData(current.copyWith(isLoadingMore: false, error: e));
    }
  }

  Future<void> uploadDispute({
    required String trackingId,
    required List<String> filePaths,
  }) async {
    final current = state.value;
    if (current == null) return;

    state = AsyncData(current.copyWith(isLoading: true));

    try {
      await ref
          .read(uploadDisputeUseCaseProvider)
          .execute(trackingId: trackingId, filePaths: filePaths);
      await applyFilters(); // Refresh list
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
