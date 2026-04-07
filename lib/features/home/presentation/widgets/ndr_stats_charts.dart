import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/core/charts/bar/app_bar_chart.dart';
import 'package:sharkship/core/charts/bar/app_horizontal_bar_chart.dart';
import 'package:sharkship/core/charts/line/app_line_chart.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/widgets/base_chart_card.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'package:intl/intl.dart';

class NDRStatsCharts extends ConsumerWidget {
  const NDRStatsCharts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ndrDataState = ref.watch(ndrDataProvider);
    final datewiseNdrState = ref.watch(datewiseNdrProvider);

    return Column(
      children: [
        // Courier breakdown
        ndrDataState.when(
          loading: () => const BaseChartCard(
            title: "NDR By Courier",
            child: Center(child: ThreeDotsLoader()),
          ),
          error: (err, _) => Center(child: Text("Error: $err")),
          data: (data) {
            if (data.ndrDataByCourier.isEmpty) {
              return const BaseChartCard(
                title: "NDR By Courier",
                child: Center(child: Text("No courier data available")),
              );
            }

            final courierPoints = data.ndrDataByCourier.map((e) {
              return ChartPoint(e.carrier, e.count.toDouble());
            }).toList();

            return BaseChartCard(
              title: "NDR By Courier",
              child: AppHorizontalBarChart(data: courierPoints),
            );
          },
        ),

        const SizedBox(height: 20),

        // Zone breakdown
        ndrDataState.when(
          loading: () => const SizedBox.shrink(), // Don't show redundant loader
          error: (err, _) => const SizedBox.shrink(),
          data: (data) {
            if (data.ndrDataByZone.isEmpty) return const SizedBox.shrink();

            final zonePoints = data.ndrDataByZone.map((e) {
              return ChartPoint(e.zone.toUpperCase(), e.count.toDouble());
            }).toList();

            return BaseChartCard(
              title: "NDR By Zone",
              child: AppBarChart(data: zonePoints),
            );
          },
        ),
        datewiseNdrState.when(
          loading: () => const BaseChartCard(
            title: "NDR Daily Trend",
            child: Center(child: ThreeDotsLoader()),
          ),
          error: (err, _) => Center(child: Text("Error: $err")),
          data: (trend) {
            if (trend.isEmpty) {
              return const BaseChartCard(
                title: "NDR Daily Trend",
                child: Center(child: Text("No datewise data available")),
              );
            }

            final points = trend.map((e) {
              return ChartPoint(
                DateFormat('dd MMM').format(e.date),
                e.count.toDouble(),
              );
            }).toList();

            return BaseChartCard(
              title: "NDR Daily Trend",
              child: Container(
                padding: const EdgeInsets.only(right: 12),
                child: AppLineChart(data: points),
              ),
            );
          },
        ),
      ],
    );
  }
}
