import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/stacked_chart_point.dart';

class AppStackedBarChart extends StatelessWidget {
  final List<StackedChartPoint> data;
  final Map<String, Color> colors;

  const AppStackedBarChart({
    super.key,
    required this.data,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("No data"));
    }

    final maxY = _getMaxY();

    return BarChart(
      BarChartData(
        maxY: maxY * 1.2, // headroom (important)
        alignment: BarChartAlignment.spaceAround,

        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),

        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= data.length) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(data[i].label),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
        ),

        barGroups: _buildGroups(),
      ),
    );
  }

  List<BarChartGroupData> _buildGroups() {
    return List.generate(data.length, (i) {
      final point = data[i];

      double running = 0;
      final stackItems = <BarChartRodStackItem>[];

      point.values.forEach((key, value) {
        if (!colors.containsKey(key)) {
          throw Exception("Missing color for key: $key");
        }

        final from = running;
        final to = running + value;

        stackItems.add(BarChartRodStackItem(from, to, colors[key]!));

        running = to;
      });

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: running,
            rodStackItems: stackItems,
            width: 18,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    });
  }

  double _getMaxY() {
    double max = 0;

    for (final point in data) {
      final sum = point.values.values.fold(0.0, (a, b) => a + b);
      if (sum > max) max = sum;
    }

    return max == 0 ? 10 : max;
  }
}
