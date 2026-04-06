import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';

class AppBarChart extends StatelessWidget {
  final List<ChartPoint> data;

  const AppBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: _titles(),
        barGroups: _groups(),
      ),
    );
  }

  List<BarChartGroupData> _groups() {
    return List.generate(
      data.length,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i].value,
            width: 18,
            borderRadius: BorderRadius.circular(3),
            color: AppChartTheme.primaryBlue,
          ),
        ],
      ),
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
              angle: -30 * pi / 180,
              child: Container(
                margin: const EdgeInsets.only(top: 3),
                child: Text(data[i].label),
              ),
            );
          },
        ),
      ),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
