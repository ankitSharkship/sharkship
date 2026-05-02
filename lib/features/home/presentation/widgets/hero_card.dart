import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharkship/shared/widgets/gradient_button.dart';

class HeroCardData {
  final String title;
  final String description;
  final String buttonText;
  final String asset;

  const HeroCardData({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.asset,
  });
}

class HeroCard extends StatelessWidget {
  final HeroCardData data;

  const HeroCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          /// SVG BACKGROUND (bottom-right, behind)
          Positioned(
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: SvgPicture.asset(
                data.asset,
                height: 130,
                fit: BoxFit.contain,
              ),
            ),
          ),

          /// CONTENT (on top)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                data.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBlue,
                    ),
              ),

              const SizedBox(height: 8),

              /// Description (important: restrict width)
              SizedBox(
                width: 220, // prevents overlap with SVG
                child: Text(
                  data.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                        height: 1.4,
                      ),
                ),
              ),

              const Spacer(),

              /// Button
              SizedBox(
                width: 160,
                child: GradientButton(
                  text: data.buttonText,
                  height: 42,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
