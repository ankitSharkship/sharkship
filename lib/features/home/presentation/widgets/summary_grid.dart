import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/dashboard_notifier.dart';
import 'package:sharkship/features/home/presentation/widgets/summary_stat_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TodayMetricsSummaryGrid extends ConsumerWidget {
  const TodayMetricsSummaryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsState = ref.watch(todayMetricsProvider);

    return metricsState.when(
      loading: () => _TodayMetricsSkeleton(),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (metrics) {
        final items = [
          (
            "Today's Order",
            "${metrics.todayOrderCount} Orders",
            metrics.orderCountPercentageIncrease,
            Icons.inventory,
          ),
          (
            "Today's Revenue",
            "₹ ${metrics.todayRevenue ?? 0}",
            metrics.revenuePercentageIncrease,
            Icons.show_chart,
          ),
          ("Average Shipping", "₹ ${0} ", 0.0, Icons.local_shipping),
          ("Total Delivery", "${0} Orders", 0.0, Icons.paid_outlined),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: 160,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, i) => SummaryStatCard(
                title: items[i].$1,
                value: items[i].$2,
                increase: items[i].$3,
                icon: items[i].$4,
                showGrowth: i < 2, // Only show growth for today's metrics
              ),
            );
          },
        );
      },
    );
  }
}

class PickupsSummaryGrid extends ConsumerWidget {
  const PickupsSummaryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsState = ref.watch(courierPickupProvider);

    return metricsState.when(
      loading: () => _TodayMetricsSkeleton(),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (metrics) {
        // Correctly access items through metrics.items
        final totalPending = metrics.items.fold<int>(
          0,
          (sum, item) => sum + item.pickupPending.count,
        );
        final totalDone = metrics.items.fold<int>(
          0,
          (sum, item) => sum + item.pickupDone.count,
        );
        final totalTomorrow = metrics.items.fold<int>(
          0,
          (sum, item) => sum + item.pickupScheduledTomorrow.count,
        );
        final grandTotalToday = metrics.items.fold<int>(
          0,
          (sum, item) => sum + item.pickupRescheduled.count,
        );

        final items = [
          ("Pickup's Order", "$totalPending Orders", Icons.inventory),
          ("Today's Pickup", "$grandTotalToday Pickups", Icons.local_shipping),
          ("Pickup's Done", "$totalDone Orders", Icons.check_circle_outline),
          ("Tomorrow's Pickup", "$totalTomorrow", Icons.schedule),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: 160,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, i) => SummaryStatCard(
                title: items[i].$1,
                value: items[i].$2,
                icon: items[i].$3,
                showGrowth: false,
              ),
            );
          },
        );
      },
    );
  }
}

class NDRSummaryGrid extends ConsumerWidget {
  const NDRSummaryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ndrStatusAsync = ref.watch(ndrStatusProvider);

    return ndrStatusAsync.when(
      loading: () => _TodayMetricsSkeleton(),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (metrics) {
        // Correctly access items through metrics.items
        if (metrics.countByNDRStatus.isEmpty) {
          return const SizedBox.shrink();
        }
        final group = metrics.countByNDRStatus.first;
        final items = [
          (
            "NDR OrderS",
            "${group.totalNdrOrders.toString()} Orders",
            Icons.inventory,
          ),
          (
            "Reattempts",
            "${group.totalReattempted} Pickups",
            Icons.local_shipping,
          ),
          (
            "NDR Delivered",
            "${group.totalDelivered} Orders",
            Icons.check_circle_outline,
          ),
          ("NDR Returned", group.totalReturned.toString(), Icons.schedule),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: 160,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, i) => SummaryStatCard(
                title: items[i].$1,
                value: items[i].$2,
                icon: items[i].$3,
                showGrowth: false,
              ),
            );
          },
        );
      },
    );
  }
}

class _TodayMetricsSkeleton extends StatelessWidget {
  const _TodayMetricsSkeleton();

  @override
  Widget build(BuildContext context) {
    final fakeItems = [
      ("Loading", "----", 0.0, Icons.inventory),
      ("Loading", "----", 0.0, Icons.show_chart),
      ("Loading", "----", 0.0, Icons.history),
      ("Loading", "----", 0.0, Icons.paid_outlined),
    ];

    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: fakeItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 160,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, i) => SummaryStatCard(
          title: fakeItems[i].$1,
          value: fakeItems[i].$2,
          increase: fakeItems[i].$3,
          icon: fakeItems[i].$4,
          showGrowth: i < 2,
        ),
      ),
    );
  }
}
