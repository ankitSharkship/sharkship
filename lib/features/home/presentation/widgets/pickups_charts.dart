import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/core/charts/bar/app_stacked_bar_chart.dart';
import 'package:sharkship/core/charts/models/stacked_chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';
import 'package:sharkship/core/charts/widgets/base_chart_card.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class PickupsCharts extends ConsumerWidget {
  const PickupsCharts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsState = ref.watch(courierPickupProvider);

    return metricsState.when(
      loading: () => const Center(
        child: Padding(padding: EdgeInsets.all(20.0), child: ThreeDotsLoader()),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (summary) {
        if (summary.items.isEmpty) {
          return BaseChartCard(
            title: "Pickups By Courier",
            child: Column(
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
                  ),
                ),
              ],
            ),
          );
        }

        // Map courier data to StackedChartPoints
        final chartData = summary.items.map((item) {
          return StackedChartPoint(item.carrier, {
            "Pickups Pending": item.pickupPending.count.toDouble(),
            "Pickups Done": item.pickupDone.count.toDouble(),
            "Pickups Rescheduled": item.pickupRescheduled.count.toDouble(),
            "Pickups Scheduled Tomorrow": item.pickupScheduledTomorrow.count
                .toDouble(),
          });
        }).toList();

        return BaseChartCard(
          title: "Pickups By Courier",
          child: AppStackedBarChart(
            data: chartData,
            colors: {
              "Pickups Pending": AppChartTheme.primaryBlue,
              "Pickups Done": AppChartTheme.secondaryBlue,
              "Pickups Rescheduled": AppChartTheme.lightBlue,
              "Pickups Scheduled Tomorrow": AppChartTheme.black,
            },
          ),
        );
      },
    );
  }
}
