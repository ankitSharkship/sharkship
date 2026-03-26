import 'package:flutter/material.dart';
import 'quick_action_item.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ("Create Shipment", Icons.inventory, Colors.blue),
      ("Bulk Upload", Icons.upload, Colors.green),
      ("Track Shipment", Icons.local_shipping, Colors.purple),
      ("Reports", Icons.bar_chart, Colors.orange),
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => QuickActionItem(
          label: items[i].$1,
          icon: items[i].$2,
          color: items[i].$3,
        ),
      ),
    );
  }
}