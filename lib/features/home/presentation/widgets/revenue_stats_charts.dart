import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/pie/app_pie_chart.dart';
import 'package:sharkship/core/charts/widgets/base_chart_card.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
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
      error: (err, _) =>  ErrorCard(
            errMssg: "Failed to Load",
            onRetry: () {
              ref.invalidate(orderRevenueProvider);

            },
          ),
      data: (data) {
        final orderDistribution = data.courierRevenues.map((e) {
          return ChartPoint(e.carrierName, e.numberOfOrders.toDouble());
        }).toList();

        return BaseChartCard(
          title: "Order Distribution",
          child: orderDistribution.isNotEmpty
              ? AppPieChart(data: orderDistribution)
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
        );
      },
    );
  }
}
