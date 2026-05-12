import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';

class AppLineChart extends StatefulWidget {
  final List<ChartPoint> data;

  const AppLineChart({super.key, required this.data});

  @override
  State<AppLineChart> createState() => _AppLineChartState();
}

class _AppLineChartState extends State<AppLineChart> {
  // ── Helpers ──────────────────────────────────────────────────────────────

  double get _maxY {
    if (widget.data.isEmpty) return 10;
    final raw = widget.data.map((p) => p.value).reduce((a, b) => a > b ? a : b);
    if (raw == 0) return 10;
    return _niceRound(raw * 1.15);
  }

  double _niceRound(double value) {
    for (final f in [5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000]) {
      final c = (value / f).ceil() * f.toDouble();
      if (c >= value) return c;
    }
    return value;
  }

  double get _yInterval {
    final step = _maxY / 5;
    for (final f in [1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000]) {
      if (f >= step) return f.toDouble();
    }
    return step;
  }

  // FIX 1: Dots clutter dense date-series. Only show them when the dataset
  //        is small enough for individual points to be meaningful.
  bool get _showDots => widget.data.length <= 10;

  // FIX 2: Label interval — same logic as the date bar chart.
  int get _labelInterval {
    final n = widget.data.length;
    if (n <= 7) return 1;
    if (n <= 14) return 2;
    if (n <= 30) return 5;
    if (n <= 60) return 7;
    return 14;
  }

  List<FlSpot> get _spots => List.generate(
    widget.data.length,
    (i) => FlSpot(i.toDouble(), widget.data[i].value),
  );

  @override
  Widget build(BuildContext context) {
    final primary = AppChartTheme.primaryBlue;

    return LineChart(
      LineChartData(
        minY: 0, // FIX 3: Anchor at zero — never float the baseline.
        maxY: _maxY, // FIX 4: Headroom so the peak doesn't clip the top edge.
        // FIX 5: Horizontal-only grid; vertical lines add noise to time-series.
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _yInterval,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: Colors.grey.shade200, strokeWidth: 1),
        ),

        borderData: FlBorderData(show: false),

        // FIX 6: Touch tooltip — essential for a trend line.
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => Colors.black87,
            tooltipBorderRadius: BorderRadius.circular(8),
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            getTooltipItems: (spots) => spots.map((spot) {
              final point = widget.data[spot.x.toInt()];
              return LineTooltipItem(
                '${point.label}\n',
                const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: NumberFormat.compact().format(spot.y),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),

        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            // FIX 7: Prevent curves from dipping below zero.
            preventCurveOverShooting: true,
            spots: _spots,
            color: primary,

            // FIX 1: Conditional dots.
            dotData: FlDotData(
              show: _showDots,
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                radius: 3,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: primary,
              ),
            ),

            // FIX 8: Area fill — standard UX for trend lines; makes the
            //        shape immediately readable even at small sizes.
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primary.withOpacity(0.18), primary.withOpacity(0.0)],
              ),
            ),
          ),
        ],

        titlesData: _titles(),
      ),
    );
  }

  FlTitlesData _titles() {
    return FlTitlesData(
      // FIX 9: Left axis was enabled but completely unconfigured — no interval,
      //        no reservedSize, no formatter. Same broken pattern as before.
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 44,
          interval: _yInterval,
          getTitlesWidget: (value, meta) {
            if (value == 0) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Text(
                NumberFormat.compact().format(value),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            );
          },
        ),
      ),

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 36,
          // FIX Bug-2: Set interval to 1 so fl_chart only calls getTitlesWidget
          // at integer X positions (0, 1, 2 …). Without this, fl_chart generates
          // its own auto-ticks (e.g. 0.0, 0.5, 1.0, 1.5 …); value.toInt()
          // then maps 0.5 → 0, 1.5 → 1 etc., and every tick that passes the
          // interval-skip check returns data[0].label — all labels look identical.
          interval: 1,
          getTitlesWidget: (value, meta) {
            // Guard: only render at exact integer indices.
            if (value != value.roundToDouble()) return const SizedBox();
            final i = value.toInt();
            if (i < 0 || i >= widget.data.length) return const SizedBox();
            if (i % _labelInterval != 0) return const SizedBox();
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Transform.rotate(
                angle: -0.5,
                alignment: Alignment.topCenter,
                child: Text(
                  widget.data[i].label,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
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
