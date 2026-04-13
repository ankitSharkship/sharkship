import 'package:flutter/material.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';

class SummaryStatCard extends StatelessWidget {
  final String title;
  final String value;
  final double? increase;
  final IconData icon;
  final bool showGrowth;

  const SummaryStatCard({
    super.key,
    required this.title,
    required this.value,
    this.increase,
    required this.icon,
    this.showGrowth = true,
  });

  @override
  Widget build(BuildContext context) {
    // Growth color and sign
    final color = increase != null
        ? (increase! >= 0 ? Colors.green : Colors.red)
        : Colors.grey;
    final sign = increase != null ? (increase! >= 0 ? "+" : "") : "";
    final iconColor = Colors.blueAccent;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          if (showGrowth) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  increase! >= 0 ? Icons.trending_up : Icons.trending_down,
                  size: 14,
                  color: color,
                ),
                const SizedBox(width: 4),
                Text(
                  "$sign${increase!.toStringAsFixed(1)}% vs yesterday",
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _comingSoon(BuildContext context) {
    GlobalPopups.showAlert(
      context: context,
      title: "Detail Info",
      body: "Full details for '$title' are coming soon in next update.",
      confirmText: "Cool",
      onConfirm: () => Navigator.pop(context),
    );
  }
}
