import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/core/charts/bar/app_bar_chart.dart';
import 'package:sharkship/core/charts/bar/app_horizontal_bar_chart.dart';
import 'package:sharkship/core/charts/line/app_line_chart.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/pie/app_pie_chart.dart';
import 'package:sharkship/core/charts/widgets/base_chart_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';

import '../state/dashboard_notifier.dart';

class DeliveredStatsCharts extends ConsumerWidget {
  const DeliveredStatsCharts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topDeliveredState = ref.watch(topDeliveredDataProvider);
    final codDataState = ref.watch(codDataProvider);

    return Column(
      children: [
        topDeliveredState.when(
          loading: () => const Column(
            children: [
              BaseChartCard(
                title: "Top Delivered City",
                child: Center(child: ThreeDotsLoader()),
              ),
              SizedBox(height: 20),
              BaseChartCard(
                title: "Top Delivered Pincode",
                child: Center(child: ThreeDotsLoader()),
              ),
            ],
          ),
          error: (err, _) => Center(child: Text("Error: $err")),
          data: (data) {
            final cityPoints = data.topDeliveredCity
                .take(5)
                .map((e) => ChartPoint(e.city, e.count.toDouble()))
                .toList();
            final pinPoints = data.topDeliveredPincode
                .take(5)
                .map((e) => ChartPoint(e.pin, e.count.toDouble()))
                .toList();
            final statePoints = data.topDeliveredState
                .take(5)
                .map((e) => ChartPoint(e.state, e.count.toDouble()))
                .toList();
            final courierPoints = data.topDeliveredCourier
                .take(5)
                .map((e) => ChartPoint(e.carrier, e.count.toDouble()))
                .toList();

            return Column(
              children: [
                // 1. Top Delivered City (Bar)
                BaseChartCard(
                  title: "Top Delivered City",
                  child: AppBarChart(data: cityPoints),
                ),
                const SizedBox(height: 20),

                // 2. Top Delivered Pincode (Pie)
                BaseChartCard(
                  title: "Top Delivered Pincode",
                  child: AppPieChart(data: pinPoints),
                ),
                const SizedBox(height: 20),

                // 3. Top Delivered State (Bar)
                BaseChartCard(
                  title: "Top Delivered State",
                  child: AppBarChart(data: statePoints),
                ),
                const SizedBox(height: 20),

                // 4. Top Delivered Courier (Horizontal Bar)
                BaseChartCard(
                  title: "Top Delivered Courier",
                  child: AppHorizontalBarChart(data: courierPoints),
                ),
                const SizedBox(height: 20),

                // 5. COD Collection Trend
                codDataState.when(
                  loading: () => const BaseChartCard(
                    title: "COD Collection Trend",
                    child: Center(child: ThreeDotsLoader()),
                  ),
                  error: (err, _) => Center(child: Text("Error: $err")),
                  data: (codTrend) {
                    if (codTrend.isEmpty) {
                      return const BaseChartCard(
                        title: "COD Collection Trend",
                        child: Center(child: Text("No COD data available")),
                      );
                    }

                    final collectionPoints = codTrend.map((e) {
                      return ChartPoint(
                        DateFormat('dd MMM').format(e.date),
                        double.tryParse(e.codCollection) ?? 0.0,
                      );
                    }).toList();

                    final countPoints = codTrend.map((e) {
                      return ChartPoint(
                        DateFormat('dd MMM').format(e.date),
                        e.codOrderCount.toDouble(),
                      );
                    }).toList();

                    return Column(
                      children: [
                        BaseChartCard(
                          title: "COD Collection Trend",
                          child: Container(
                            padding: const EdgeInsets.only(right: 12),
                            child: AppLineChart(data: collectionPoints),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BaseChartCard(
                          title: "COD Order Count Trend",
                          child: Container(
                            padding: const EdgeInsets.only(right: 12),
                            child: AppLineChart(data: countPoints),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
