import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_tabbar.dart';
import 'package:sharkship/shared/constants/colors.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(ordersTabProvider);

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const OrdersHeader(),
            OrdersTabbar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: _buildTabContent(selectedTab, ref),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [ColorManager.primaryBlue, ColorManager.secondaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () => {},
          child: const Icon(Icons.add, size: 35, color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTabContent(int tab, WidgetRef ref) {
    switch (tab) {
      case 0:
        return Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SvgPicture.asset(
                    'assets/images/orders/no_orders.svg',
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'No Orders Found',
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorManager.secondaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Start by creating a new order to manage and\n track it easily from this dashboard',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        );
      case 1:
        return const Center(child: Text("Tab2"));
      default:
        return const Center(child: Text("Coming Soon"));
    }
  }
}
