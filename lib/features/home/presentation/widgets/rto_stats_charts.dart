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
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';

import '../state/dashboard_notifier.dart';

class RtoStatsCharts extends ConsumerWidget {
  const RtoStatsCharts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topRtoState = ref.watch(topRtoDataProvider);
    final datewiseRtoState = ref.watch(datewiseRtoProvider);

    return Column(
      children: [
        // Daily Trend
        const SizedBox(height: 20),

        topRtoState.when(
          loading: () => const Column(
            children: [
              BaseChartCard(
                title: "Top RTO Pincode",
                child: Center(child: ThreeDotsLoader()),
              ),
              SizedBox(height: 20),
              BaseChartCard(
                title: "Top RTO City",
                child: Center(child: ThreeDotsLoader()),
              ),
            ],
          ),
          error: (err, _) => ErrorCard(
            errMssg: "Failed to Load",
            onRetry: () {
              ref.invalidate(topRtoDataProvider);
              ref.invalidate(datewiseRtoProvider);
            },
          ),
          data: (data) {
            final pinPoints = data.topRtoPincode
                .take(5)
                .map((e) => ChartPoint(e.pin, e.count.toDouble()))
                .toList();
            final cityPoints = data.topRtoCity
                .take(5)
                .map((e) => ChartPoint(e.city, e.count.toDouble()))
                .toList();
            final statePoints = data.topRtoState
                .take(5)
                .map((e) => ChartPoint(e.state, e.count.toDouble()))
                .toList();
            final courierPoints = data.topRtoCourier
                .take(5)
                .map((e) => ChartPoint(e.carrier, e.count.toDouble()))
                .toList();

            return Column(
              children: [
                BaseChartCard(
                  title: "Top RTO City",
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
                BaseChartCard(
                  title: "Top RTO Pincode",
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
                BaseChartCard(
                  title: "Top RTO State",
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

                // 4. Top RTO Courier (Horizontal Bar)
                BaseChartCard(
                  title: "Top RTO Courier",
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

                datewiseRtoState.when(
                  loading: () => const BaseChartCard(
                    title: "RTO Daily Trend",
                    child: Center(child: ThreeDotsLoader()),
                  ),
                  error: (err, _) => Center(child: Text("Error: $err")),
                  data: (trend) {
                    if (trend.isEmpty) {
                      return BaseChartCard(
                        title: "RTO Daily Trend",
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

                    final points = trend.map((e) {
                      return ChartPoint(
                        DateFormat('dd MMM').format(e.date),
                        e.count.toDouble(),
                      );
                    }).toList();

                    return BaseChartCard(
                      title: "RTO Daily Trend",
                      child: Container(
                        padding: const EdgeInsets.only(right: 12),
                        child: AppLineChart(data: points),
                      ),
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
