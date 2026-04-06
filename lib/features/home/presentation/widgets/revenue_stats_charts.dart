import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/pie/app_pie_chart.dart';
import 'package:sharkship/core/charts/widgets/base_chart_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/dashboard_notifier.dart';

class RevenueStatsCharts extends ConsumerWidget {
  const RevenueStatsCharts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenueState = ref.watch(orderRevenueProvider);

    return revenueState.when(
      loading: () => const BaseChartCard(
        title: "Order Distribution",
        child: Center(child: ThreeDotsLoader()),
      ),
      error: (err, _) => Center(child: Text("Error: $err")),
      data: (data) {
        final orderDistribution = data.courierRevenues.map((e) {
          return ChartPoint(
            e.carrierName,
            e.numberOfOrders.toDouble(),
          );
        }).toList();

        return BaseChartCard(
          title: "Order Distribution",
          child: AppPieChart(data: orderDistribution),
        );
      },
    );
  }
}
