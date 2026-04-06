import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';

class AppMultiLineChart extends StatelessWidget {
  final List<MultiLinePoint> data;
  final Map<String, Color> seriesColors;

  const AppMultiLineChart({
    super.key,
    required this.data,
    required this.seriesColors,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: _titles(),
        lineBarsData: _lines(),
      ),
    );
  }

  List<LineChartBarData> _lines() {
    return seriesColors.entries.map((entry) {
      final key = entry.key;
      final color = entry.value;

      return LineChartBarData(
        color: color,
        spots: List.generate(
          data.length,
          (i) => FlSpot(i.toDouble(), data[i].values[key] ?? 0),
        ),
      );
    }).toList();
  }

  FlTitlesData _titles() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) {
            final i = value.toInt();
            if (i >= data.length) return const SizedBox();
            return Text(data[i].label);
          },
        ),
      ),
    );
  }
}