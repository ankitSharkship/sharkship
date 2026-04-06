import 'package:flutter/material.dart';

class ChartLegend extends StatelessWidget {
  final Map<String, Color> items;

  const ChartLegend({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: items.entries.map((e) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 10, height: 10, color: e.value),
            const SizedBox(width: 6),
            Text(e.key),
          ],
        );
      }).toList(),
    );
  }
}