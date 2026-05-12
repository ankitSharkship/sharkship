// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:sharkship/core/charts/models/stacked_chart_point.dart';

// class AppStackedBarChart extends StatelessWidget {
//   final List<StackedChartPoint> data;
//   final Map<String, Color> colors;

//   const AppStackedBarChart({
//     super.key,
//     required this.data,
//     required this.colors,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (data.isEmpty) {
//       return const Center(child: Text("No data"));
//     }

//     final maxY = _getMaxY();

//     return BarChart(
//       BarChartData(
//         maxY: maxY * 1.2, // headroom (important)
//         alignment: BarChartAlignment.spaceAround,

//         gridData: FlGridData(show: true),
//         borderData: FlBorderData(show: false),

//         titlesData: FlTitlesData(
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 final i = value.toInt();
//                 if (i < 0 || i >= data.length) {
//                   return const SizedBox();
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 6),
//                   child: Text(data[i].label),
//                 );
//               },
//             ),
//           ),
//           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//         ),

//         barGroups: _buildGroups(),
//       ),
//     );
//   }

//   List<BarChartGroupData> _buildGroups() {
//     return List.generate(data.length, (i) {
//       final point = data[i];

//       double running = 0;
//       final stackItems = <BarChartRodStackItem>[];

//       point.values.forEach((key, value) {
//         if (!colors.containsKey(key)) {
//           throw Exception("Missing color for key: $key");
//         }

//         final from = running;
//         final to = running + value;

//         stackItems.add(BarChartRodStackItem(from, to, colors[key]!));

//         running = to;
//       });

//       return BarChartGroupData(
//         x: i,
//         barRods: [
//           BarChartRodData(
//             toY: running,
//             rodStackItems: stackItems,
//             width: 18,
//             borderRadius: BorderRadius.circular(6),
//           ),
//         ],
//       );
//     });
//   }

//   double _getMaxY() {
//     double max = 0;

//     for (final point in data) {
//       final sum = point.values.values.fold(0.0, (a, b) => a + b);
//       if (sum > max) max = sum;
//     }

//     return max == 0 ? 10 : max;
//   }
// }


// ─────────────────────────────────────────────────────────────────────────────
// 2. AppStackedBarChart  (chart widget)
// ─────────────────────────────────────────────────────────────────────────────
 
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/core/charts/models/stacked_chart_point.dart';

class AppStackedBarChart extends StatefulWidget {
  final List<StackedChartPoint> data;
  final Map<String, Color> colors;
 
  // FIX 4: Explicit ordered key list prevents map-iteration order bugs.
  final List<String> orderedKeys;
 
  const AppStackedBarChart({
    super.key,
    required this.data,
    required this.colors,
    required this.orderedKeys,
  });
 
  @override
  State<AppStackedBarChart> createState() => _AppStackedBarChartState();
}
 
class _AppStackedBarChartState extends State<AppStackedBarChart> {
  int? _touchedGroupIndex;
  String? _touchedKey; // which segment was tapped
 
  // ── Helpers ─────────────────────────────────────────────────────────────────
 
  double get _maxY {
    double max = 0;
    for (final point in widget.data) {
      final sum = widget.orderedKeys
          .map((k) => point.values[k] ?? 0.0)
          .fold(0.0, (a, b) => a + b);
      if (sum > max) max = sum;
    }
    // FIX 5: Use a consistent 20% headroom, rounded to a nice step,
    //        so the tallest bar never touches the top edge.
    if (max == 0) return 10;
    final padded = max * 1.2;
    return _niceRound(padded);
  }
 
  double _niceRound(double value) {
    for (final factor in [5, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000]) {
      final candidate = (value / factor).ceil() * factor.toDouble();
      if (candidate >= value) return candidate;
    }
    return value;
  }
 
  double get _yInterval {
    final step = _maxY / 5;
    if (step <= 0) return 1;
    for (final factor in [1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000]) {
      if (factor >= step) return factor.toDouble();
    }
    return step;
  }
 
  // FIX 6: Dynamic bar width — prevents overflow for many carriers,
  //        prevents pencil-thin bars for few carriers.
  double get _barWidth {
    final n = widget.data.length;
    if (n <= 3) return 28;
    if (n <= 6) return 22;
    if (n <= 10) return 16;
    return 12;
  }
 
  // ── Build ────────────────────────────────────────────────────────────────────
 
  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(child: Text("No data"));
    }
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FIX 7: Add a legend. Stacked charts are unreadable without one —
        //        the user must know what each color segment represents.
        _Legend(colors: widget.colors, orderedKeys: widget.orderedKeys),
        const SizedBox(height: 12),
        Expanded(child: _buildChart()),
      ],
    );
  }
 
  Widget _buildChart() {
    return BarChart(
      BarChartData(
        minY: 0, // FIX 8: Always anchor Y axis at zero.
        maxY: _maxY,
        alignment: BarChartAlignment.spaceAround,
 
        // FIX 9: Horizontal-only, subtle grid lines. The original showed
        //        vertical grid lines too, which add noise to stacked charts.
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _yInterval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.shade200,
            strokeWidth: 1,
          ),
        ),
 
        borderData: FlBorderData(show: false),
 
        // FIX 10: Touch interaction with per-segment tooltip.
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.black87,
            tooltipBorderRadius: BorderRadius.circular(8),
            tooltipPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final point = widget.data[group.x];
              final total = widget.orderedKeys
                  .map((k) => point.values[k] ?? 0.0)
                  .fold(0.0, (a, b) => a + b);
 
              // Build one line per segment, bold the touched one.
              final lines = widget.orderedKeys.map((key) {
                final val = point.values[key] ?? 0.0;
                final pct = total > 0 ? (val / total * 100).round() : 0;
                return TextSpan(
                  text: '${key.replaceAll("Pickups ", "")}: '
                      '${NumberFormat.compact().format(val)} ($pct%)\n',
                  style: TextStyle(
                    color: widget.colors[key]?.withOpacity(1) ?? Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList();
 
              return BarTooltipItem(
                '${point.label}\n',
                const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                children: [
                  ...lines,
                  TextSpan(
                    text: 'Total: ${NumberFormat.compact().format(total)}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            },
          ),
          touchCallback: (event, response) {
            setState(() {
              if (event is FlTapUpEvent || event is FlPointerExitEvent) {
                _touchedGroupIndex = null;
              } else {
                _touchedGroupIndex = response?.spot?.touchedBarGroupIndex;
              }
            });
          },
        ),
 
        titlesData: _buildTitles(),
        barGroups: _buildGroups(),
      ),
      swapAnimationDuration: const Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeInOut,
    );
  }
 
  // ── Titles ───────────────────────────────────────────────────────────────────
 
  FlTitlesData _buildTitles() {
    return FlTitlesData(
      // FIX 11: Y-axis was enabled but had no configuration — no interval,
      //         no reservedSize, no label formatting. This caused label clipping
      //         and unreadable raw numbers. Now fully configured.
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
          // FIX 12: Reserve space so carrier name labels are never clipped.
          reservedSize: 32,
          getTitlesWidget: (value, meta) {
            final i = value.toInt();
            if (i < 0 || i >= widget.data.length) return const SizedBox();
            final label = widget.data[i].label;
            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                // FIX 13: Truncate long carrier names to prevent overflow.
                label.length > 10 ? '${label.substring(0, 9)}…' : label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
 
      rightTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
 
  // ── Bar groups ───────────────────────────────────────────────────────────────
 
  List<BarChartGroupData> _buildGroups() {
    return List.generate(widget.data.length, (i) {
      final point = widget.data[i];
      final isTouched = i == _touchedGroupIndex;
 
      double running = 0;
      final stackItems = <BarChartRodStackItem>[];
 
      // FIX 14: Iterate in explicit key order (not map order) so segment
      //         colors always match the legend.
      for (final key in widget.orderedKeys) {
        final value = point.values[key] ?? 0.0;
        if (value <= 0) continue; // FIX 15: Skip zero-value segments —
        // they render a 1px artefact that muddies the border radius.
 
        final color = widget.colors[key];
        if (color == null) throw Exception("Missing color for key: $key");
 
        stackItems.add(BarChartRodStackItem(running, running + value, color));
        running += value;
      }
 
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: running,
            rodStackItems: stackItems,
            width: _barWidth, // FIX 6: dynamic width
            // FIX 16: Only round the top corners of a stacked bar.
            //         Rounding all corners splits the visual at the base and
            //         looks disconnected from the axis.
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(4)),
            // FIX 17: Dim non-touched bars when one is active — gives clear
            //         focus without hiding data.
            color: isTouched || _touchedGroupIndex == null
                ? null // null = use rodStackItems colors
                : Colors.grey.shade300,
          ),
        ],
      );
    });
  }
}
 
// ─────────────────────────────────────────────────────────────────────────────
// 3. _Legend  (new widget)
// ─────────────────────────────────────────────────────────────────────────────
 
class _Legend extends StatelessWidget {
  final Map<String, Color> colors;
  final List<String> orderedKeys;
 
  const _Legend({required this.colors, required this.orderedKeys});
 
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      children: orderedKeys.map((key) {
        final color = colors[key] ?? Colors.grey;
        // Strip the "Pickups " prefix for compact legend labels.
        final shortLabel = key.replaceAll('Pickups ', '');
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              shortLabel,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
 