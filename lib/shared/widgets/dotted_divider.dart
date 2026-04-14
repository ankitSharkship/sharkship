import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final double height;
  final double dotWidth;
  final double spacing;
  final Color color;

  const DottedDivider({
    super.key,
    this.height = 2,
    this.dotWidth = 4,
    this.spacing = 4,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxCount = (constraints.maxWidth / (dotWidth + spacing)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(boxCount, (_) {
            return SizedBox(
              width: dotWidth,
              height: height,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
