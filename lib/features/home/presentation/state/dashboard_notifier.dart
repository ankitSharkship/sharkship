import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';

import '../../domain/entities/today_metrics.dart';
import '../../domain/entities/order_status_summary.dart';
import '../../domain/entities/ndr_status_summary.dart';
import '../../domain/entities/ndr_data.dart';
import '../../domain/entities/datewise_ndr_count.dart';
import 'dashboard_providers.dart';

part 'dashboard_notifier.g.dart';

/// -------------------------------
/// Today Metrics Notifier
/// -------------------------------
@riverpod
class TodayMetricsNotifier extends _$TodayMetricsNotifier {
  @override
  Future<TodayMetrics> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getTodayMetricsUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getTodayMetricsUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

/// -------------------------------
/// Order Status Notifier
/// -------------------------------
@riverpod
class OrderStatusNotifier extends _$OrderStatusNotifier {
  @override
  Future<OrderStatusSummary> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getOrderStatusCountUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getOrderStatusCountUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

/// -------------------------------
/// NDR Status Notifier
/// -------------------------------
@riverpod
class NdrStatusNotifier extends _$NdrStatusNotifier {
  @override
  Future<NdrStatusSummary> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getNdrStatusCountUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getNdrStatusCountUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

@riverpod
class CourierPickupNotifier extends _$CourierPickupNotifier {
  @override
  Future<CarrierPickupSummaryList> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getCarrierPickupDataUsecaseProvider)(
      "TODAY",
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh({String day = "TODAY"}) async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getCarrierPickupDataUsecaseProvider)(
        day,
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

/// -------------------------------
/// NDR Data Notifier (By Zone/Courier)
/// -------------------------------
@riverpod
class NdrDataNotifier extends _$NdrDataNotifier {
  @override
  Future<NdrData> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getNdrDataUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getNdrDataUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

/// -------------------------------
/// Datewise NDR Count Notifier
/// -------------------------------
@riverpod
class DatewiseNdrCountNotifier extends _$DatewiseNdrCountNotifier {
  @override
  Future<List<DatewiseNdrCount>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getDatewiseNdrCountUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getDatewiseNdrCountUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}
