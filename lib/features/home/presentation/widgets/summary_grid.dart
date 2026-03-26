import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/dashboard_notifier.dart';
import 'package:sharkship/features/home/presentation/widgets/summary_stat_card.dart';

class SummaryGrid extends ConsumerWidget {
  const SummaryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsState = ref.watch(todayMetricsProvider);

    return metricsState.when(
      loading: () => const Center(heightFactor: 3, child: ThreeDotsLoader()),
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
          (
            "Yesterday's Orders",
            "${metrics.yesterdayOrderCount} Orders",
            0.0,
            Icons.history,
          ),
          (
            "Yesterday's Revenue",
            "₹ ${metrics.yesterdayRevenue ?? 0}",
            0.0,
            Icons.paid_outlined,
          ),
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
                mainAxisExtent: 120,
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
