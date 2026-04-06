import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';

class AppAreaChart extends StatelessWidget {
  final List<ChartPoint> data;

  const AppAreaChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              data.length,
              (i) => FlSpot(i.toDouble(), data[i].value),
            ),
            isCurved: true,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppChartTheme.primaryBlue.withOpacity(0.3),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}