import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';

class AppPieChart extends StatelessWidget {
  final List<ChartPoint> data;

  const AppPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ✅ Pie Chart
        Expanded(
          flex: 2,
          child: PieChart(
            PieChartData(centerSpaceRadius: 40, sections: _sections()),
          ),
        ),

        const SizedBox(width: 16),

        // ✅ Legends
        Expanded(flex: 1, child: _legend()),
      ],
    );
  }

  List<PieChartSectionData> _sections() {
    return List.generate(data.length, (i) {
      final color = _getColor(i);

      return PieChartSectionData(
        value: data[i].value,
        title: '${data[i].value}',
        radius: 50,
        color: color,
      );
    });
  }

  Widget _legend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(data.length, (i) {
        final color = _getColor(i);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              // color indicator
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),

              // label
              Expanded(
                child: Text(
                  data[i].label,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // simple color palette
  Color _getColor(int i) {
    const colors = [
      AppChartTheme.primaryBlue,
      AppChartTheme.secondaryBlue,
      AppChartTheme.lightBlue,
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.teal,
    ];
    return colors[i % colors.length];
  }
}
