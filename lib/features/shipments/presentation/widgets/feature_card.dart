import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class FeatureCardData {
  final IconData icon;
  final String title;
  final String description;
  final bool isPrimary; // true = solid blue card, false = outlined card

  const FeatureCardData({
    required this.icon,
    required this.title,
    required this.description,
    required this.isPrimary,
  });
}

class FeatureCard extends StatelessWidget {
  final FeatureCardData cardData;

  const FeatureCard({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    final isPrimary = cardData.isPrimary;

    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primaryBlue : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isPrimary
            ? null
            : Border.all(color: const Color(0xFFE5E8EF), width: 1.5),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.30),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon circle
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isPrimary
                  ? Colors.white.withOpacity(0.18)
                  : AppColors.lightBlueBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              cardData.icon,
              size: 26,
              color: isPrimary ? Colors.white : AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            cardData.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isPrimary ? Colors.white : AppColors.primaryBlue,
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            cardData.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: isPrimary
                      ? Colors.white.withOpacity(0.88)
                      : const Color(0xFF6B7280),
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
