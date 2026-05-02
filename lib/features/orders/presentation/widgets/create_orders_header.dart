import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateOrdersHeader extends StatelessWidget {
  const CreateOrdersHeader({super.key});

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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 10),
          Text(
            "Create Orders",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     IconButton(
          //       onPressed: () => _showSearchBar(context),
          //       icon: const Icon(Icons.search, size: 22),
          //     ),
          //     IconButton(
          //       onPressed: () => _showSearchBar(context),
          //       icon: const Icon(Icons.settings, size: 22),
          //     ),
          //     IconButton(
          //       onPressed: () => _showSearchBar(context),
          //       icon: const Icon(Icons.sort, size: 22),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
