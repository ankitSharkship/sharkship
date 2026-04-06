import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sharkship/core/charts/models/chart_point.dart';

class MultiRingChart extends StatelessWidget {
  final List<ChartPoint> data;

  const MultiRingChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MultiRingPainter(data),
    );
  }
}


class _MultiRingPainter extends CustomPainter {
  final List<ChartPoint> data;

  _MultiRingPainter(this.data);

  final List<Color> colors = const [
    Color(0xFF7FA9D6), // light blue
    Color(0xFF2C46A6), // dark blue
    Color(0xFF2F66D8), // bright blue
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final double baseRadius = size.width / 2;

    final double strokeWidth = 18;
    final double gap = 10;

    final maxValue = data.map((e) => e.value).reduce(max);

    for (int i = 0; i < data.length; i++) {
      final radius = baseRadius - (i * (strokeWidth + gap));

      final rect = Rect.fromCircle(center: center, radius: radius);

      final backgroundPaint = Paint()
        ..color = Colors.grey.shade300
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final valuePaint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      // background circle
      canvas.drawArc(rect, 0, 2 * pi, false, backgroundPaint);

      // value arc
      final sweepAngle = (data[i].value / maxValue) * 2 * pi;

      canvas.drawArc(
        rect,
        -pi / 2, // start from top
        sweepAngle,
        false,
        valuePaint,
      );

      // draw value text near arc end
      final angle = -pi / 2 + sweepAngle;
      final textOffset = Offset(
        center.dx + (radius) * cos(angle),
        center.dy + (radius) * sin(angle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: data[i].value.toStringAsFixed(2),
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        textOffset - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}