import 'dart:math';
import 'package:flutter/material.dart';

class ThreeDotsLoader extends StatefulWidget {
  final int dotCount;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Duration duration;

  const ThreeDotsLoader({
    super.key,
    this.dotCount = 3,
    this.size = 12,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.duration = const Duration(milliseconds: 900),
  });

  @override
  State<ThreeDotsLoader> createState() => _ThreeDotsLoaderState();
}

class _ThreeDotsLoaderState extends State<ThreeDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  double _calcValue(int index) {
    final phase = (2 * pi / widget.dotCount) * index;
    final value = sin((_controller.value * 2 * pi) - phase);
    return (value + 1) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.dotCount, (i) {
            final t = _calcValue(i);

            final scale = 0.8 + (t * 0.6); // smooth scaling
            final color =
                Color.lerp(widget.inactiveColor, widget.activeColor, t)!;

            return Transform.scale(
              scale: scale,
              child: Container(
                width: widget.size,
                height: widget.size,
                margin: EdgeInsets.symmetric(horizontal: widget.size * 0.4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
