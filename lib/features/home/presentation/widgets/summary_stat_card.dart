import 'package:flutter/material.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

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
    final iconColor = AppColors.primaryBlue;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          bottom: BorderSide(color: AppColors.primaryBlue, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
