import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/screens/dashboard_screen.dart';

import 'package:sharkship/features/more/presentation/screens/more_screen.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/orders/presentation/screens/orders_screen.dart';

import 'package:sharkship/features/shipments/presentation/screens/shipments_screen.dart';
import 'package:sharkship/features/support/presentation/screens/support_screen.dart';
import 'package:sharkship/shared/constants/colors.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    final screens = [
      const DashboardScreen(),
      const OrdersScreen(),
      ShipmentsScreen(),
      const SupportScreen(),
      const MoreScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,
        onTap: (index) {
          ref.read(bottomNavProvider.notifier).state = index;
        },
        buttonBackgroundColor: ColorManager.white,
        backgroundColor: ColorManager.lightBlue,
        height: 60,
        items: const [
          Icon(Icons.home),
          Icon(Icons.inventory_2),
          Icon(Icons.local_shipping),
          Icon(Icons.support_agent),
          Icon(Icons.more_horiz),
        ],
      ),
    );
  }
}
