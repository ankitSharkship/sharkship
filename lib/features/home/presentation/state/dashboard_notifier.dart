import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';

import '../../domain/entities/today_metrics.dart';
import '../../domain/entities/order_status_summary.dart';
import '../../domain/entities/ndr_status_summary.dart';
import '../../domain/entities/ndr_data.dart' as NdrDataEntity;
import '../../domain/entities/datewise_ndr_count.dart' as DatewiseNdrCountEntity;
import '../../domain/entities/top_rto_data.dart' as TopRtoDataEntity;
import '../../domain/entities/datewise_rto_count.dart' as DatewiseRtoCountEntity;
import '../../domain/entities/top_delivered_data.dart' as TopDeliveredDataEntity;
import '../../domain/entities/cod_data.dart' as CodDataEntity;
import '../../domain/entities/order_revenue.dart' as OrderRevenueEntity;
import 'dashboard_providers.dart';

part 'dashboard_notifier.g.dart';

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

@riverpod
class NdrData extends _$NdrData {
  @override
  Future<NdrDataEntity.NdrData> build() async {
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

@riverpod
class DatewiseNdrCount extends _$DatewiseNdrCount {
  @override
  Future<List<DatewiseNdrCountEntity.DatewiseNdrCount>> build() async {
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

@riverpod
class TopRtoData extends _$TopRtoData {
  @override
  Future<TopRtoDataEntity.TopRtoData> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getTopRtoDataUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getTopRtoDataUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

@riverpod
class DatewiseRtoCount extends _$DatewiseRtoCount {
  @override
  Future<List<DatewiseRtoCountEntity.DatewiseRtoCount>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getDatewiseRtoCountUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getDatewiseRtoCountUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

@riverpod
class TopDeliveredData extends _$TopDeliveredData {
  @override
  Future<TopDeliveredDataEntity.TopDeliveredData> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getTopDeliveredDataUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getTopDeliveredDataUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

@riverpod
class CodData extends _$CodData {
  @override
  Future<List<CodDataEntity.CodData>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getCodDataUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getCodDataUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}

@riverpod
class OrderRevenue extends _$OrderRevenue {
  @override
  Future<OrderRevenueEntity.OrderRevenue> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return ref.read(getOrderRevenueUseCaseProvider)(
      startDate: dateRange.start,
      endDate: dateRange.end,
    );
  }

  Future<void> refresh() async {
    final dateRange = ref.read(dashboardDateProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getOrderRevenueUseCaseProvider)(
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }
}
