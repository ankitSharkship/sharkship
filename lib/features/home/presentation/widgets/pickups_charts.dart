import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/core/charts/bar/app_stacked_bar_chart.dart';
import 'package:sharkship/core/charts/models/stacked_chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';
import 'package:sharkship/core/charts/widgets/base_chart_card.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1. PickupsCharts  (outer shell)
// ─────────────────────────────────────────────────────────────────────────────

class PickupsCharts extends ConsumerWidget {
  const PickupsCharts({super.key});

  // Stable key ordering so every chart draw uses the same segment sequence.
  static const List<String> _keys = [
    "Pickups Done",
    "Pickups Pending",
    "Pickups Rescheduled",
    "Pickups Scheduled Tomorrow",
  ];

  static const Map<String, Color> _colors = {
    "Pickups Done": AppChartTheme.secondaryBlue,
    "Pickups Pending": AppChartTheme.primaryBlue,
    "Pickups Rescheduled": AppChartTheme.lightBlue,
    "Pickups Scheduled Tomorrow": AppChartTheme.black,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsState = ref.watch(courierPickupProvider);

    return metricsState.when(
      loading: () => const Center(
        child: Padding(padding: EdgeInsets.all(20), child: ThreeDotsLoader()),
      ),
      error: (err, stack) => ErrorCard(
        errMssg: "Failed to Load",
        onRetry: () => ref.invalidate(courierPickupProvider),
      ),
      data: (summary) {
        if (summary.items.isEmpty) {
          return BaseChartCard(
            title: "Pickups By Courier",
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/home/no_orders.svg',
                  width: 200,
                  fit: BoxFit.fitWidth,
                ),
                Center(
                  child: Text(
                    'No Data Available\nSelect a different date range',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          );
        }
        final chartData = summary.items.map((item) {
          return StackedChartPoint(item.carrier, {
            for (final k in _keys)
              k: switch (k) {
                "Pickups Pending" => item.pickupPending.count.toDouble(),
                "Pickups Done" => item.pickupDone.count.toDouble(),
                "Pickups Rescheduled" =>
                  item.pickupRescheduled.count.toDouble(),
                _ => item.pickupScheduledTomorrow.count.toDouble(),
              },
          });
        }).toList();

        return BaseChartCard(
          title: "Pickups By Courier",
          child: AppStackedBarChart(
            data: chartData,
            // FIX 3: Pass ordered key list so the chart renders legend and
            //        stacks in a predictable, semantically sensible order
            //        (Done → Pending → Rescheduled → Tomorrow).
            orderedKeys: _keys,
            colors: _colors,
          ),
        );
      },
    );
  }
}
