import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/screens/dashboard_screen.dart';
import 'package:sharkship/features/more/presentation/screens/more_screen.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/orders/presentation/screens/orders_screen.dart';
import 'package:sharkship/features/shipments/presentation/screens/shipments_screen.dart';
import 'package:sharkship/features/tickets/presentation/screens/tickets_screen.dart';
import 'package:sharkship/shared/constants/colors.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    final screens = [
      const DashboardScreen(),
      const OrdersScreen(),
      const ShipmentsScreen(),
      const TicketsScreen(),
      const MoreScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(bottomNavProvider.notifier).state = index;
        },
        type: BottomNavigationBarType.fixed, // important for 5 items
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.secondaryBlue, // adjust if needed
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Shipments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
