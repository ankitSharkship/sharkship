import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';
import 'package:sharkship/core/charts/theme/chart_theme.dart';

class AppHorizontalBarChart extends StatelessWidget {
  final List<ChartPoint> data;

  const AppHorizontalBarChart({super.key, required this.data});

  // Blue shades from darkest (top bar) to lightest (bottom bar)
  static const List<Color> _barColors = [
    Color(0xFF1A3F7A),
    Color(0xFF2E6FBF),
    Color(0xFF4A9BD4),
    Color(0xFF7BBDE8),
    Color(0xFFAAD7F5),
  ];

  Color _colorFor(int index) {
    if (index < _barColors.length) return _barColors[index];
    return AppChartTheme.primaryBlue;
  }

  @override
  Widget build(BuildContext context) {
    final sorted = [...data]..sort((a, b) => b.value.compareTo(a.value));
    final total = sorted.fold<double>(0, (s, p) => s + p.value);
    final maxVal = sorted.isEmpty ? 1.0 : sorted.first.value;

    return LayoutBuilder(
      builder: (context, constraints) {
        final longestLabel = sorted.fold<int>(
          0,
          (m, p) => p.label.length > m ? p.label.length : m,
        );
        final labelWidth = (longestLabel * 7.5).clamp(60.0, 100.0);
        const bottomAxisHeight = 28.0;
        const barSpacing = 12.0;
        const barHeight = 36.0;
        final chartHeight =
            sorted.length * (barHeight + barSpacing) + barSpacing;

        return SizedBox(
          height: chartHeight + bottomAxisHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Left label column ──────────────────────────────────────
              SizedBox(
                width: labelWidth,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: sorted.map((point) {
                          return SizedBox(
                            height: barHeight,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  point.label,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF444444),
                                  ),
                                  textAlign: TextAlign.right,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: bottomAxisHeight),
                  ],
                ),
              ),

              // ── Bar area ───────────────────────────────────────────────
              Expanded(
                child: CustomPaint(
                  painter: _HorizontalBarPainter(
                    data: sorted,
                    total: total,
                    maxVal: maxVal,
                    colors: List.generate(sorted.length, _colorFor),
                    barHeight: barHeight,
                    barSpacing: barSpacing,
                    bottomAxisHeight: bottomAxisHeight,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HorizontalBarPainter extends CustomPainter {
  final List<ChartPoint> data;
  final double total;
  final double maxVal;
  final List<Color> colors;
  final double barHeight;
  final double barSpacing;
  final double bottomAxisHeight;

  _HorizontalBarPainter({
    required this.data,
    required this.total,
    required this.maxVal,
    required this.colors,
    required this.barHeight,
    required this.barSpacing,
    required this.bottomAxisHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final chartWidth = size.width;
    final chartHeight = size.height - bottomAxisHeight;

    // ── Axis lines ────────────────────────────────────────────────────
    final axisPaint = Paint()
      ..color = const Color(0xFFD0D0D0)
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(0, chartHeight),
      Offset(chartWidth, chartHeight),
      axisPaint,
    );
    canvas.drawLine(const Offset(0, 0), Offset(0, chartHeight), axisPaint);

    // ── Vertical grid lines + bottom tick labels ──────────────────────
    final gridPaint = Paint()
      ..color = const Color(0xFFE8E8E8)
      ..strokeWidth = 1;

    final tickStyle = const TextStyle(fontSize: 11, color: Color(0xFF999999));
    final interval = _niceInterval(maxVal);

    double tick = 0;
    while (tick <= maxVal * 1.05) {
      final x = maxVal > 0 ? (tick / maxVal) * chartWidth : 0.0;
      if (tick > 0) {
        canvas.drawLine(Offset(x, 0), Offset(x, chartHeight), gridPaint);
      }
      final tp = TextPainter(
        text: TextSpan(text: tick.toInt().toString(), style: tickStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, chartHeight + 6));
      tick += interval;
    }

    // ── Bars ──────────────────────────────────────────────────────────
    final radius = Radius.circular(5);

    for (int i = 0; i < data.length; i++) {
      final point = data[i];
      final barWidth = maxVal > 0 ? (point.value / maxVal) * chartWidth : 0.0;
      final top = barSpacing + i * (barHeight + barSpacing);

      final rect = RRect.fromRectAndCorners(
        Rect.fromLTWH(0, top, barWidth, barHeight),
        topLeft: radius,
        bottomLeft: radius,
        topRight: radius,
        bottomRight: radius,
      );

      canvas.drawRRect(rect, Paint()..color = colors[i]);

      // ── Inside label ──────────────────────────────────────────────
      final pct = total > 0 ? (point.value / total * 100) : 0.0;
      final label = '${point.value.toInt()}(${pct.toStringAsFixed(2)}%)';
      final labelY = top + (barHeight - 12) / 2;
      final insidePainter = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final labelX = barWidth - insidePainter.width - 10;

      if (labelX > 4) {
        // Fits inside bar
        insidePainter.paint(canvas, Offset(labelX, labelY));
      } else {
        // Bar too short — render outside in dark colour
        final outsidePainter = TextPainter(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Color(0xFF444444),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        outsidePainter.paint(canvas, Offset(barWidth + 6, labelY));
      }
    }
  }

  double _niceInterval(double maxVal) {
    if (maxVal <= 10) return 2;
    if (maxVal <= 30) return 5;
    if (maxVal <= 60) return 10;
    if (maxVal <= 150) return 25;
    return (maxVal / 5).ceilToDouble();
  }

  @override
  bool shouldRepaint(_HorizontalBarPainter old) =>
      old.data != data || old.maxVal != maxVal;
}
