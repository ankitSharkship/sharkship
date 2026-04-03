import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';

import '../../domain/entities/today_metrics.dart';
import '../../domain/entities/order_status_summary.dart';
import '../../domain/entities/ndr_status_summary.dart';
import 'dashboard_providers.dart';

part 'dashboard_notifier.g.dart';

/// -------------------------------
/// Today Metrics Notifier
/// -------------------------------
@riverpod
class TodayMetricsNotifier extends _$TodayMetricsNotifier {
  @override
  Future<TodayMetrics> build() async {
    return ref.read(getTodayMetricsUseCaseProvider)();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getTodayMetricsUseCaseProvider)(),
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
    return ref.read(getOrderStatusCountUseCaseProvider)();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getOrderStatusCountUseCaseProvider)(),
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
    return ref.read(getNdrStatusCountUseCaseProvider)();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getNdrStatusCountUseCaseProvider)(),
    );
  }
}

@riverpod
class CourierPickupNotifier extends _$CourierPickupNotifier {
  @override
  Future<CarrierPickupSummaryList> build() async {
    return ref.read(getCarrierPickupDataUsecaseProvider)("TODAY");
  }

  Future<void> refresh({String day = "TODAY"}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getCarrierPickupDataUsecaseProvider)(day),
    );
  }
}
