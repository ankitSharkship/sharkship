import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../../domain/entities/order_revenue.dart';

class RevenueBreakdownTable extends ConsumerWidget {
  const RevenueBreakdownTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenueState = ref.watch(orderRevenueProvider);
    return revenueState.when(
      loading: () => ThreeDotsLoader(),
      error: (error, stackTrace) => ErrorWidget(error),
      data: (revenue) {
        final data = revenue.courierRevenues;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppChartTheme.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Detailed Revenue Breakdown",
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
                    DataColumn(label: Text('Carrier')),
                    DataColumn(label: Text('Orders')),
                    DataColumn(label: Text('Prepaid')),
                    DataColumn(label: Text('Prepaid Rev')),
                    DataColumn(label: Text('COD')),
                    DataColumn(label: Text('COD Rev')),
                    DataColumn(label: Text('Total Rev')),
                  ],
                  rows: data.map((e) {
                    return DataRow(
                      cells: [
                        DataCell(Text(e.carrierName)),
                        DataCell(Text('${e.numberOfOrders}')),
                        DataCell(Text('${e.prepaidOrders}')),
                        DataCell(Text('₹ ${e.revenuePrepaid}')),
                        DataCell(Text('${e.codOrders}')),
                        DataCell(Text('₹ ${e.revenueCod}')),
                        DataCell(Text('₹ ${e.totalRevenue}')),
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
