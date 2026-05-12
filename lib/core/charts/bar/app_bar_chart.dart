import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';

class AppBarChart extends StatefulWidget {
  final List<ChartPoint> data;

  // FIX 1: Allow callers to hint how much bottom space to reserve.
  //        City names need more room than 2-letter state codes.
  final double bottomReservedSize;

  const AppBarChart({
    super.key,
    required this.data,
    this.bottomReservedSize = 48, // safe default for medium-length labels
  });

  @override
  State<AppBarChart> createState() => _AppBarChartState();
}

class _AppBarChartState extends State<AppBarChart> {
  int? _touchedIndex;

  // ── Helpers ──────────────────────────────────────────────────────────────

  // FIX 2: maxY with nice rounding + headroom (same pattern as previous fixes).
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

  // FIX 3: Dynamic bar width.
  double get _barWidth {
    final n = widget.data.length;
    if (n <= 3) return 28;
    if (n <= 6) return 22;
    if (n <= 10) return 16;
    return 12;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        minY: 0, // FIX 4: Always anchor at zero.
        maxY: _maxY,

        // FIX 5: Horizontal-only, subtle grid; no vertical noise.
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _yInterval,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: Colors.grey.shade200, strokeWidth: 1),
        ),

        borderData: FlBorderData(show: false),

        // FIX 6: Touch tooltip showing label + compact value.
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.black87,
            tooltipBorderRadius: BorderRadius.circular(8),
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final point = widget.data[group.x];
              return BarTooltipItem(
                '${point.label}\n',
                const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: NumberFormat.compact().format(rod.toY),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            },
          ),
          touchCallback: (event, response) {
            setState(() {
              _touchedIndex =
                  (event is FlTapUpEvent || event is FlPointerExitEvent)
                  ? null
                  : response?.spot?.touchedBarGroupIndex;
            });
          },
        ),

        titlesData: _titles(),
        barGroups: _groups(),
      ),
      swapAnimationDuration: const Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeInOut,
    );
  }

  List<BarChartGroupData> _groups() {
    final primary = AppChartTheme.primaryBlue;
    return List.generate(widget.data.length, (i) {
      final isTouched = i == _touchedIndex;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: widget.data[i].value,
            width: _barWidth, // FIX 3
            // FIX 7: Only round the top corners — flat base looks grounded.
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                primary.withOpacity(isTouched ? 0.9 : 0.65),
                primary.withOpacity(isTouched ? 1.0 : 0.85),
              ],
            ),
          ),
        ],
      );
    });
  }

  FlTitlesData _titles() {
    return FlTitlesData(
      // FIX 8: Left axis — fully configured (was completely absent).
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
          // FIX 9: Reserve adequate height so rotated labels are never clipped.
          //        Caller can override via bottomReservedSize.
          reservedSize: widget.bottomReservedSize,
          getTitlesWidget: (value, _) {
            final i = value.toInt();
            if (i < 0 || i >= widget.data.length) return const SizedBox();
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Transform.rotate(
                // FIX 10: Use -0.5 rad (~28°) — shallower than -30° so
                //         descenders don't collide with the axis line.
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

class AppDateBarChart extends StatefulWidget {
  final List<ChartDatePoint> data;

  const AppDateBarChart({super.key, required this.data});

  @override
  State<AppDateBarChart> createState() => _AppDateBarChartState();
}

class _AppDateBarChartState extends State<AppDateBarChart> {
  int? _touchedIndex;

  // ── Helpers ──────────────────────────────────

  /// Dynamic bar width: narrow for many bars, wider for few.
  double get _barWidth {
    final count = widget.data.length;
    if (count <= 7) return 20;
    if (count <= 14) return 14;
    if (count <= 30) return 9;
    return 6;
  }

  /// Axis label interval — same logic as before.
  int get _labelInterval {
    final n = widget.data.length;
    if (n <= 7) return 1;
    if (n <= 14) return 2;
    if (n <= 30) return 5;
    if (n <= 60) return 7;
    return 14;
  }

  /// FIX 5: Compute a clean maxY with ~15 % head-room so the tallest bar
  ///        never butts against the top edge, and round up to a nice number.
  double get _maxY {
    final rawMax = widget.data
        .map((p) => p.value)
        .fold(0.0, (a, b) => a > b ? a : b);
    if (rawMax == 0) return 10;
    final padded = rawMax * 1.15;
    // Round up to the nearest "nice" increment.
    final magnitude = (padded / 5).ceil() * 5.0;
    return magnitude < padded ? padded : magnitude;
  }

  /// FIX 6: Y-axis interval — pick a step that yields ~4-6 labels.
  double get _yInterval {
    final step = _maxY / 5;
    if (step <= 0) return 1;
    // Round to nearest power-of-ten magnitude for clean numbers.
    final magnitude = _niceStep(step);
    return magnitude;
  }

  double _niceStep(double rawStep) {
    if (rawStep <= 0) return 1;
    final mag = (rawStep / (10 * rawStep.floor().toString().length)).round();
    // Snap to 1 / 2 / 5 × 10^n
    for (final factor in [1, 2, 5, 10, 20, 50, 100, 200, 500, 1000]) {
      if (factor >= rawStep) return factor.toDouble();
    }
    return rawStep;
  }

  // ── Build ─────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = AppChartTheme.primaryBlue;

    return BarChart(
      BarChartData(
        // FIX 7: Always start Y at 0. Never let fl_chart auto-scale from a
        //        non-zero baseline — it visually exaggerates differences.
        minY: 0,
        maxY: _maxY,

        // FIX 8: Subtle horizontal grid only; no vertical clutter.
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _yInterval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.shade200,
            strokeWidth: 1,
            dashArray: null, // solid, not dashed — cleaner at small sizes
          ),
        ),

        borderData: FlBorderData(show: false),

        // FIX 9: Touch interaction — highlight the tapped bar and show value.
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // Tooltip background adapts to theme.
            getTooltipColor: (_) => Colors.black87,
            tooltipBorderRadius: BorderRadius.circular(10),
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final point = widget.data[group.x];
              return BarTooltipItem(
                '${DateFormat('dd MMM').format(point.label)}\n',
                const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    // FIX 10: Format large numbers with commas (e.g. 1,200).
                    text: NumberFormat.compact().format(rod.toY),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            },
          ),
          touchCallback: (event, response) {
            setState(() {
              if (event is FlTapUpEvent || event is FlPointerExitEvent) {
                _touchedIndex = null;
              } else {
                _touchedIndex = response?.spot?.touchedBarGroupIndex;
              }
            });
          },
        ),

        titlesData: _buildTitles(),
        barGroups: _buildGroups(primaryColor),
      ),
      // Smooth animation when data changes.
      swapAnimationDuration: const Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeInOut,
    );
  }

  // ── Bar groups ────────────────────────────────

  List<BarChartGroupData> _buildGroups(Color primary) {
    return List.generate(widget.data.length, (i) {
      final isTouched = i == _touchedIndex;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: widget.data[i].value,
            // FIX 11: Dynamic bar width prevents bars from overflowing or
            //         looking too thin on datasets of different sizes.
            width: _barWidth,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            // FIX 12: Visual feedback on touch — brighten the active bar.
            color: isTouched ? primary : primary.withOpacity(0.75),
            // FIX 13: Subtle gradient gives bars depth without gimmickry.
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                primary.withOpacity(isTouched ? 0.9 : 0.65),
                primary.withOpacity(isTouched ? 1.0 : 0.85),
              ],
            ),
          ),
        ],
      );
    });
  }

  // ── Titles ────────────────────────────────────

  FlTitlesData _buildTitles() {
    return FlTitlesData(
      // FIX 14: Show left (Y) axis titles. This was completely missing before —
      //         without a Y axis, users cannot read absolute values.
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          // Reserve enough space so labels don't overlap the bars.
          reservedSize: 44,
          interval: _yInterval,
          getTitlesWidget: (value, meta) {
            // Skip the 0 label to avoid clutter at the baseline.
            if (value == 0) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Text(
                // FIX 15: Compact format (1K, 2M) keeps labels short.
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
          // FIX 16: Reserve height so date labels aren't clipped.
          reservedSize: 28,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= widget.data.length) {
              return const SizedBox.shrink();
            }
            if (index % _labelInterval != 0) {
              return const SizedBox.shrink();
            }
            final date = widget.data[index].label;
            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                DateFormat('dd MMM').format(date),
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
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
