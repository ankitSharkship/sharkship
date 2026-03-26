import 'package:flutter/material.dart';
import 'package:sharkship/features/home/presentation/screens/dashboard_screen.dart';
import 'package:sharkship/features/home/presentation/screens/home_page_backup.dart';
import 'package:sharkship/features/more/presentation/screens/more_screen.dart';
import 'package:sharkship/features/orders/presentation/screens/orders_screen.dart';
import 'package:sharkship/features/shipments/presentation/screens/shipments_screen.dart';
import 'package:sharkship/features/support/presentation/screens/support_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const OrdersScreen(),
    const ShipmentsScreen(),
    const SupportScreen(),
    const MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF1E88C8),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.inventory_2, "Orders", 1),
            _buildNavItem(Icons.local_shipping, "Shipments", 2),
            _buildNavItem(Icons.support_agent, "Support", 3),
            _buildNavItem(Icons.more_horiz, "More", 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: isSelected && index == 0
          ? ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF6EC1E4), Color(0xFF1E88C8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: Icon(icon, color: Colors.white),
            )
          : Icon(icon),
      label: label,
    );
  }
}
