import 'package:flutter/material.dart';

class OrdersHeader extends StatelessWidget {
  const OrdersHeader({super.key});

  void _showSearchBar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Orders",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _showSearchBar(context),
                icon: const Icon(Icons.search, size: 22),
              ),
              IconButton(
                onPressed: () => _showSearchBar(context),
                icon: const Icon(Icons.settings, size: 22),
              ),
              IconButton(
                onPressed: () => _showSearchBar(context),
                icon: const Icon(Icons.sort, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
