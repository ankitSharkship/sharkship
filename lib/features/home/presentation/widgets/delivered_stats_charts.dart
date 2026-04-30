import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/core/charts/bar/app_bar_chart.dart';
import 'package:sharkship/core/charts/bar/app_horizontal_bar_chart.dart';
import 'package:sharkship/core/charts/line/app_line_chart.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/pie/app_pie_chart.dart';
import 'package:sharkship/core/charts/widgets/base_chart_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'package:sharkship/shared/widgets/loader.dart';

import '../state/dashboard_notifier.dart';

class DeliveredStatsCharts extends ConsumerWidget {
  const DeliveredStatsCharts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveredData = ref.watch(topDeliveredDataProvider);
    final codDataState = ref.watch(codTrendProvider);

    return Column(
      children: [
        deliveredData.when(
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
                  child: cityPoints.isNotEmpty
                      ? AppBarChart(data: cityPoints)
                      : SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/images/home/no_orders.svg',
                                width: 200,
                                fit: BoxFit.fitWidth,
                              ),
                              Center(
                                child: Text(
                                  'No Data Available\nPlace some orders to view the data',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 20),

                // 2. Top Delivered Pincode (Pie)
                BaseChartCard(
                  title: "Top Delivered Pincode",
                  child: pinPoints.isNotEmpty
                      ? AppPieChart(data: pinPoints)
                      : SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/images/home/no_orders.svg',
                                width: 200,
                                fit: BoxFit.fitWidth,
                              ),
                              Center(
                                child: Text(
                                  'No Data Available\nPlace some orders to view the data',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 20),

                // 3. Top Delivered State (Bar)
                BaseChartCard(
                  title: "Top Delivered State",
                  child: statePoints.isNotEmpty
                      ? AppBarChart(data: statePoints)
                      : SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/images/home/no_orders.svg',
                                width: 200,
                                fit: BoxFit.fitWidth,
                              ),
                              Center(
                                child: Text(
                                  'No Data Available\nPlace some orders to view the data',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 20),

                // 4. Top Delivered Courier (Horizontal Bar)
                BaseChartCard(
                  title: "Top Delivered Courier",
                  child: courierPoints.isNotEmpty
                      ? AppHorizontalBarChart(data: courierPoints)
                      : SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/images/home/no_orders.svg',
                                width: 200,
                                fit: BoxFit.fitWidth,
                              ),
                              Center(
                                child: Text(
                                  'No Data Available\nPlace some orders to view the data',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                      return BaseChartCard(
                        title: "COD Collection Trend",
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/home/no_orders.svg',
                              width: 200,
                              fit: BoxFit.fitWidth,
                            ),
                            Center(
                              child: Text(
                                'No Data Available\nPlace some orders to view the data',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
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
                            child: collectionPoints.isNotEmpty
                                ? AppLineChart(data: collectionPoints)
                                : SizedBox(
                                    width: double.maxFinite,
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/home/no_orders.svg',
                                          width: 200,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        Center(
                                          child: Text(
                                            'No Data Available\nPlace some orders to view the data',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BaseChartCard(
                          title: "COD Order Count Trend",
                          child: Container(
                            padding: const EdgeInsets.only(right: 12),
                            child: countPoints.isNotEmpty
                                ? AppLineChart(data: countPoints)
                                : SizedBox(
                                    width: double.maxFinite,
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/home/no_orders.svg',
                                          width: 200,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        Center(
                                          child: Text(
                                            'No Data Available\nPlace some orders to view the data',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
