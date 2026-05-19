import 'package:flutter/material.dart';

class AdaptiveGradientIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final double size;
  final Color selectedStartColor;
  final Color selectedEndColor;
  final Color unselectedColor;

  const AdaptiveGradientIcon({
    super.key,
    required this.icon,
    required this.isSelected,
    this.size = 24,
    this.selectedStartColor = const Color(0xFF1D5FAF),
    this.selectedEndColor = const Color(0xFF45C2F5),
    this.unselectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    if (!isSelected) {
      return Icon(
        icon,
        size: size,
        color: unselectedColor,
      );
    }

    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            selectedStartColor,
            selectedEndColor,
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}