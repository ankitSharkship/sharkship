import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/core/charts/bar/app_bar_chart.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/pie/app_pie_chart.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/dashboard_notifier.dart';
import 'package:intl/intl.dart';

class BusinessOverviewChart extends ConsumerWidget {
  const BusinessOverviewChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessState = ref.watch(businessOverviewProvider);

    return businessState.when(
      loading: () => const Center(child: ThreeDotsLoader()),
      error: (e, _) => Center(child: Text("Error: $e")),
      data: (data) {
        final chartData = data
            .map(
              (e) => ChartPoint(
                DateFormat('dd MMM').format(e.date),
                e.count.toDouble(),
              ),
            )
            .toList();

        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Business Trends",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (data.isEmpty)
                Expanded(
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
                )
              else ...[
                Expanded(child: AppBarChart(data: chartData)),
              ],
            ],
          ),
        );
      },
    );
  }
}

class ZoneDistributionOverviewChart extends ConsumerWidget {
  const ZoneDistributionOverviewChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zoneState = ref.watch(zoneDistributionProvider);

    return zoneState.when(
      loading: () => const Center(child: ThreeDotsLoader()),
      error: (e, _) => Center(child: Text("Error: $e")),
      data: (data) {
        final total = data.fold<int>(0, (sum, item) => sum + item.count);
        final chartItems = data
            .map(
              (e) => ChartPoint(
                e.zone.replaceAll('_', ' ').toUpperCase(),
                total == 0
                    ? 0.0
                    : ((e.count / total) * 100 * 100).round() / 100,
              ),
            )
            .toList();

        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Distribution by Zone",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (data.isEmpty)
                Expanded(
                  
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
                )
              else ...[
                Expanded(child: AppPieChart(data: chartItems)),
              ],
            ],
          ),
        );
      },
    );
  }
}

class StateWiseOrdersTable extends ConsumerWidget {
  const StateWiseOrdersTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapOrdersProvider);

    return mapState.when(
      loading: () => const Center(child: ThreeDotsLoader()),
      error: (e, _) => Center(child: Text("Error: $e")),
      data: (data) {
        final Map<String, Map<String, int>> grouped = {};

        for (final e in data) {
          grouped.putIfAbsent(
            e.state,
            () => {
              "SHIPPED": 0,
              "OUT_FOR_DELIVERY": 0,
              "DELIVERED": 0,
              "RETURNED": 0,
            },
          );

          grouped[e.state]![e.status] =
              (grouped[e.state]![e.status] ?? 0) + e.count;
        }
        if (data.isEmpty) {
          return SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            // border: Border.all(color: AppChartTheme.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "State-wise Order Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24,
                  headingRowColor: WidgetStateProperty.all(
                    ColorManager.primaryBlue.withOpacity(0.05),
                  ),
                  columns: const [
                    DataColumn(label: Text('State')),
                    DataColumn(label: Text('In Transit')),
                    DataColumn(label: Text('Out For delivery')),
                    DataColumn(label: Text('Delivered')),
                    DataColumn(label: Text("Returned")),
                  ],
                  rows: grouped.entries.map((entry) {
                    final state = entry.key;
                    final statusMap = entry.value;
                    print(statusMap);
                    return DataRow(
                      cells: [
                        DataCell(Text(state)),
                        DataCell(Text(statusMap["SHIPPED"].toString())),
                        DataCell(
                          Text(statusMap["OUT_FOR_DELIVERY"].toString()),
                        ),
                        DataCell(Text(statusMap["DELIVERED"].toString())),
                        DataCell(Text(statusMap["RETURNED"].toString())),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
