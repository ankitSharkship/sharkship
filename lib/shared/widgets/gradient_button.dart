import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isActive;
  final double height;
  final BorderRadius borderRadius;
  final List<Color>? gradientColors;
  final double? width;
  final Widget? child;

  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isActive = true,
    this.height = 56,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.gradientColors,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors =
        gradientColors ??
        [
          ColorManager.primaryBlue,
          ColorManager.secondaryBlue,
          ColorManager.lightBlue,
        ];

    return Opacity(
      opacity: isActive ? 1 : 0.6,
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        elevation: 3,
        child: InkWell(
          onTap: isActive ? onTap : null,
          borderRadius: borderRadius,
          child: Ink(
            height: height,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: borderRadius,
            ),
            child: Center(
              child: child ?? Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
