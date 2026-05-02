import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';

enum SectionCardVariant { standard, compact }

class SectionCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;

  /// Icon config
  final IconData? icon;
  final String? svgAsset;

  /// Styling
  final Color iconColor;
  final Color iconBackgroundColor;
  final List<Color>? buttonGradient;

  /// Layout variant
  final SectionCardVariant variant;

  const SectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,

    this.icon,
    this.svgAsset,

    this.iconColor = const Color(0xFF1E88C8),
    this.iconBackgroundColor = const Color(0xFFEAF3FB),
    this.buttonGradient,

    this.variant = SectionCardVariant.standard,
  }) : assert(
         icon != null || svgAsset != null,
         "Either icon or svgAsset must be provided",
       );

  @override
  Widget build(BuildContext context) {
    final isCompact = variant == SectionCardVariant.compact;

    return Container(
      padding: EdgeInsets.all(isCompact ? 12 : 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON BOX
          Container(
            height: isCompact ? 50 : 60,
            width: isCompact ? 50 : 60,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: _buildIcon()),
          ),

          const SizedBox(width: 12),

          /// CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isCompact ? 13 : 14,
                  ),
                ),

                const SizedBox(height: 4),

                /// DESCRIPTION
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isCompact ? 11 : 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 10),

                /// BUTTON
                SizedBox(
                  width: isCompact ? 120 : 140,
                  child: GradientButton(
                    text: buttonText,
                    height: isCompact ? 32 : 36,
                    borderRadius: BorderRadius.circular(8),
                    gradientColors: buttonGradient,
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (svgAsset != null) {
      return SvgPicture.asset(
        svgAsset!,
        height: 26,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      );
    }

    return Icon(icon, color: iconColor, size: 26);
  }

 
}
