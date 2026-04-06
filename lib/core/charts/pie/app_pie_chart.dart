import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';

class AppPieChart extends StatelessWidget {
  final List<ChartPoint> data;

  const AppPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 40,
        sections: _sections(),
      ),
    );
  }

  List<PieChartSectionData> _sections() {
    return List.generate(data.length, (i) {
      return PieChartSectionData(
        value: data[i].value,
        title: '${data[i].value}',
        radius: 50,
      );
    });
  }
}