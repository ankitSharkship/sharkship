import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:sharkship/features/home/presentation/screens/dashboard_screen.dart';
import 'package:sharkship/features/kyc/presentation/screens/kyc_screen.dart';
import 'package:sharkship/features/more/presentation/screens/more_screen.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/nav/presentation/widgets/active_gradient_icon.dart';
import 'package:sharkship/features/orders/presentation/screens/orders_screen.dart';
import 'package:sharkship/features/shipments/presentation/screens/shipment_tracking.dart';
import 'package:sharkship/features/shipments/presentation/screens/shipments_screen.dart';
import 'package:sharkship/features/tickets/presentation/screens/tickets_screen.dart';
import 'package:sharkship/features/user/presentation/screens/support_user_screen.dart';
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
        userRole == UserRole.supportUser || userRole == UserRole.operationsUser;

    final screens = [
      if (showDashboard) const DashboardScreen(),

      if (showOrders) ...[const OrdersScreen(), const ShipmentsScreen()],

      if (showTickets) const TicketsScreen(),

      if (userRole == UserRole.operationsUser) const ShipmentTracking(),

      showOnlyProfile ? const SupportUserScreen() : const MoreScreen(),
    ];

    final navItems = <BottomNavigationBarItem>[];

    int currentNavIndex = 0;

    if (showDashboard) {
      navItems.add(
        BottomNavigationBarItem(
          icon: AdaptiveGradientIcon(
            icon: Icons.home_rounded,
            isSelected: selectedIndex == currentNavIndex,
          ),
          label: 'Home',
        ),
      );

      currentNavIndex++;
    }

    if (showOrders) {
      navItems.addAll([
        BottomNavigationBarItem(
          icon: AdaptiveGradientIcon(
            icon: Icons.inventory_2_rounded,
            isSelected: selectedIndex == currentNavIndex,
          ),
          label: 'Orders',
        ),

        BottomNavigationBarItem(
          icon: AdaptiveGradientIcon(
            icon: Icons.local_shipping_rounded,
            isSelected: selectedIndex == currentNavIndex + 1,
          ),
          label: 'Shipments',
        ),
      ]);

      currentNavIndex += 2;
    }

    if (showTickets) {
      navItems.add(
        BottomNavigationBarItem(
          icon: AdaptiveGradientIcon(
            icon: Icons.support_agent_rounded,
            isSelected: selectedIndex == currentNavIndex,
          ),
          label: 'Tickets',
        ),
      );

      currentNavIndex++;
    }

    if (userRole == UserRole.operationsUser) {
      navItems.add(
        BottomNavigationBarItem(
          icon: AdaptiveGradientIcon(
            icon: Icons.electric_scooter_rounded,
            isSelected: selectedIndex == currentNavIndex,
          ),
          label: 'Tracking',
        ),
      );

      currentNavIndex++;
    }

    navItems.add(
      BottomNavigationBarItem(
        icon: AdaptiveGradientIcon(
          icon: showOnlyProfile
              ? Icons.person_rounded
              : Icons.more_horiz_rounded,
          isSelected: selectedIndex == currentNavIndex,
        ),
        label: showOnlyProfile ? 'Profile' : 'More',
      ),
    );

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
            properties: {'tab': label, 'user_role': userRole?.name ?? "N/A"},
          );
        },

        type: BottomNavigationBarType.fixed,

        backgroundColor: ColorManager.white,

        selectedItemColor: ColorManager.secondaryBlue,

        unselectedItemColor: Colors.grey,

        showUnselectedLabels: true,

        elevation: 10,

        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),

        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),

        items: navItems,
      ),
    );
  }
}
