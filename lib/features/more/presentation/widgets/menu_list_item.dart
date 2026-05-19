import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final List<List<dynamic>>? icon2;
  final bool isDropdown;
  final VoidCallback? onTap;
  final List<MenuItem>? children;

  MenuItem({
    required this.title,
    required this.icon,
    this.icon2,
    this.isDropdown = false,
    this.onTap,
    this.children,
  });
}

class MenuListItem extends StatefulWidget {
  final MenuItem item;

  const MenuListItem({super.key, required this.item});

  @override
  State<MenuListItem> createState() => _MenuListItemState();
}

class _MenuListItemState extends State<MenuListItem> {
  bool isExpanded = false;

  void handleTap() {
    if (widget.item.isDropdown) {
      setState(() => isExpanded = !isExpanded);
    } else {
      widget.item.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// PARENT TILE
        InkWell(
          onTap: handleTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                item.icon2 != null
                    ? GradientIcon(
                        size: 28,
                        child: HugeIcon(
                          icon: item.icon2!,
                          color: AppColors.primaryBlue,
                          size: 28,
                        ),
                      )
                    : GradientIcon(
                        size: 28,
                        child: Icon(
                          item.icon,
                          color: AppColors.primaryBlue,
                          size: 28,
                        ),
                      ),
                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    item.title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.black87),
                  ),
                ),

                if (item.isDropdown)
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isExpanded ? 0.5 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primaryBlue,
                    ),
                  ),
              ],
            ),
          ),
        ),

        /// CHILDREN (DROPDOWN)
        if (item.isDropdown && isExpanded)
          Column(
            children: item.children!
                .map(
                  (child) => InkWell(
                    onTap: child.onTap,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          child.icon2 != null
                              ? HugeIcon(
                                  icon: child.icon2!,
                                  size: 18,
                                  color: AppColors.primaryBlue,
                                )
                              : Icon(
                                  child.icon,
                                  size: 18,
                                  color: AppColors.primaryBlue,
                                ),
                          const SizedBox(width: 10),
                          Text(
                            child.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class GradientIcon extends StatelessWidget {
  final Widget child;
  final double size;

  const GradientIcon({super.key, required this.child, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1D5FAF), Color(0xFF45C2F5)],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: SizedBox(width: size, height: size, child: child),
    );
  }
}
