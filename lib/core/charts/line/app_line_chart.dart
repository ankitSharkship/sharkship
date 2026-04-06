import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';

class AppLineChart extends StatelessWidget {
  final List<ChartPoint> data;

  const AppLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
        titlesData: _titles(),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: _spots(),
            color: AppChartTheme.primaryBlue,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _spots() {
    return List.generate(
      data.length,
      (i) => FlSpot(i.toDouble(), data[i].value),
    );
  }

  FlTitlesData _titles() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) {
            final i = value.toInt();
            if (i >= data.length) return const SizedBox();
            return Transform.rotate(
              angle: -30 * pi / 180, // degrees → radians
              child: Container(
                margin: const EdgeInsets.only(top: 3),
                child: Text(data[i].label),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
