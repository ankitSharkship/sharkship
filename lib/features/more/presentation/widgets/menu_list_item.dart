import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final bool isDropdown;
  final VoidCallback? onTap;
  final List<MenuItem>? children;

  MenuItem({
    required this.title,
    required this.icon,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                Icon(item.icon, color: Colors.blue, size: 22),
                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),

                if (item.isDropdown)
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isExpanded ? 0.5 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.blue,
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
                          Icon(
                            child.icon,
                            size: 18,
                            color: Colors.blueGrey,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            child.title,
                            style: const TextStyle(fontSize: 14),
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