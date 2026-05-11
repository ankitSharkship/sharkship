import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:sharkship/features/home/presentation/screens/dashboard_screen.dart';
import 'package:sharkship/features/kyc/presentation/screens/kyc_screen.dart';
import 'package:sharkship/features/more/presentation/screens/more_screen.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/orders/presentation/screens/orders_screen.dart';
import 'package:sharkship/features/shipments/presentation/screens/shipment_tracking.dart';
import 'package:sharkship/features/shipments/presentation/screens/shipments_screen.dart';
import 'package:sharkship/features/tickets/presentation/screens/tickets_screen.dart';
import 'package:sharkship/features/user/presentation/screens/support_user_screen.dart';
import 'package:sharkship/features/user/presentation/screens/user_screen.dart';
import 'package:sharkship/features/user/presentation/state/user_role.dart';
import 'package:sharkship/shared/constants/colors.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);
    final permissions = ref.read(allowedFeaturesProvider);
    final userRole = ref.watch(userRoleProvider);
    final showDashboard = permissions.contains(AppFeature.dashboards);
    final showOrders = permissions.contains(AppFeature.orders);

    final showTickets = permissions.contains(AppFeature.tickets);
    final showOnlyProfile =
        (userRole == UserRole.supportUser) ||
        (userRole == UserRole.operationsUser);

    final screens = [
      if (showDashboard) const DashboardScreen(),
      if (showOrders) ...[const OrdersScreen(), const ShipmentsScreen()],
      if (showTickets) const TicketsScreen(),
      if (userRole == UserRole.operationsUser) const ShipmentTracking(),
      showOnlyProfile ? const SupportUserScreen() : const MoreScreen(),
    ];

    final navItems = [
      if (showDashboard)
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      if (showOrders) ...[
        const BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2),
          label: 'Orders',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.local_shipping),
          label: 'Shipments',
        ),
      ],
      if (showTickets)
        const BottomNavigationBarItem(
          icon: Icon(Icons.support_agent),
          label: 'Tickets',
        ),
      if (userRole == UserRole.operationsUser)
        const BottomNavigationBarItem(
          icon: Icon(Icons.electric_scooter_rounded),
          label: 'Tracking',
        ),
      showOnlyProfile
          ? const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          : const BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
    ];
    final safeIndex = selectedIndex >= screens.length ? 0 : selectedIndex;
    if (navItems.length < 2) {
      return Scaffold(body: IndexedStack(index: 0, children: screens));
    }

    return Scaffold(
      body: IndexedStack(index: safeIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: safeIndex,
        onTap: (index) {
          ref.read(bottomNavProvider.notifier).setIndex(index);
          final label = navItems[index].label ?? 'unknown';
          Posthog().screen(screenName: label);
          Posthog().capture(
            eventName: 'bottom_tab_switched',
            properties: {
              'tab': label,
              'user_role': userRole?.name ?? "N/A",
            },
          );
        },
        type: BottomNavigationBarType.fixed, // important for 5 items
        backgroundColor: ColorManager.white,
        selectedItemColor: ColorManager.secondaryBlue, // adjust if needed
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: navItems,
      ),
    );
  }
}
