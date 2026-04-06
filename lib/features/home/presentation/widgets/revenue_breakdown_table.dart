import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';
import 'package:sharkship/shared/constants/colors.dart';
import '../../domain/entities/order_revenue.dart';

class RevenueBreakdownTable extends StatelessWidget {
  final List<CourierRevenue> data;

  const RevenueBreakdownTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
  }
}
