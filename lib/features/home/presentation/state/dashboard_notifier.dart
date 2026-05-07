import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/home/domain/entities/ndr_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/order_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';
import 'package:sharkship/features/home/domain/entities/ndr_data.dart' as nd;
import 'package:sharkship/features/home/domain/entities/datewise_ndr_count.dart';
import 'package:sharkship/features/home/domain/entities/today_metrics.dart'
    as tm;
import 'package:sharkship/features/home/domain/entities/top_rto_data.dart'
    as rto;
import 'package:sharkship/features/home/domain/entities/datewise_rto_count.dart';
import 'package:sharkship/features/home/domain/entities/top_delivered_data.dart'
    as td;
import 'package:sharkship/features/home/domain/entities/cod_data.dart' as c;
import 'package:sharkship/features/home/domain/entities/order_revenue.dart'
    as rev;
import 'package:sharkship/features/home/domain/entities/remittance_overview.dart'
    as rem;
import 'package:sharkship/features/home/domain/entities/business_entities.dart'
    as be;
import 'dashboard_providers.dart';

part 'dashboard_notifier.g.dart';

@riverpod
class DashboardDate extends _$DashboardDate {
  @override
  DateTimeRange build() {
    print('DEBUG: DashboardDate.build called');
    final now = DateTime.now();
    final endOfDay = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));
    return DateTimeRange(
      start: now.subtract(const Duration(days: 7)),
      end: endOfDay,
    );
  }

  void updateRange(DateTimeRange range) {
    state = range;
  }
}

@riverpod
class TodayMetrics extends _$TodayMetrics {
  @override
  FutureOr<tm.TodayMetrics> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getTodayMetricsUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class OrderStatus extends _$OrderStatus {
  @override
  FutureOr<OrderStatusSummary> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getOrderStatusSummaryUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class NdrStatus extends _$NdrStatus {
  @override
  FutureOr<NdrStatusSummary> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getNdrStatusSummaryUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class CourierPickup extends _$CourierPickup {
  @override
  FutureOr<CarrierPickupSummaryList> build() async {
    return await ref.read(getCarrierPickupDataUseCaseProvider).call("TODAY");
  }
}

@riverpod
class NdrData extends _$NdrData {
  @override
  FutureOr<nd.NdrData> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getNdrDataUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class DatewiseNdr extends _$DatewiseNdr {
  @override
  FutureOr<List<DatewiseNdrCount>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getDatewiseNdrCountUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class TopRtoData extends _$TopRtoData {
  @override
  FutureOr<rto.TopRtoData> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getTopRtoDataUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class DatewiseRto extends _$DatewiseRto {
  @override
  FutureOr<List<DatewiseRtoCount>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getDatewiseRtoCountUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class TopDeliveredData extends _$TopDeliveredData {
  @override
  FutureOr<td.TopDeliveredData> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getTopDeliveredDataUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class CodTrend extends _$CodTrend {
  @override
  FutureOr<List<c.CodData>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getCodDataUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class OrderRevenue extends _$OrderRevenue {
  @override
  FutureOr<rev.OrderRevenue> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getOrderRevenueUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class RemittanceOverview extends _$RemittanceOverview {
  @override
  FutureOr<rem.RemittanceOverview> build() async {
    return await ref.read(getRemittanceOverviewUseCaseProvider).call();
  }
}

@riverpod
class BusinessOverview extends _$BusinessOverview {
  @override
  FutureOr<List<be.BusinessOverviewCount>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getBusinessOverviewUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class MapOrders extends _$MapOrders {
  @override
  FutureOr<List<be.StateStatusCount>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getMapOrdersUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}

@riverpod
class ZoneDistribution extends _$ZoneDistribution {
  @override
  FutureOr<List<be.ZonePercentageCount>> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    return await ref
        .read(getZoneDistributionUseCaseProvider)
        .call(startDate: dateRange.start, endDate: dateRange.end);
  }
}
