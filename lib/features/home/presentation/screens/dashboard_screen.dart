import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/home/presentation/widgets/ndr_grid.dart';
import 'package:sharkship/features/home/presentation/widgets/shipment_grid.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../providers/dashboard_tab_provider.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_tabbar.dart';
import '../widgets/section_title.dart';

import '../widgets/summary_grid.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(dashboardTabProvider);

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const DashboardHeader(),

            DashboardTabBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildTabContent(selectedTab, ref),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int tab, WidgetRef ref) {
    switch (tab) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TodayMetricsSummaryGrid(),
            SizedBox(height: 20),
            SectionTitle("Shipments Details"),
            SizedBox(height: 12),
            ShipmentGrid(),
            SizedBox(height: 20),
            SectionTitle("NDR Details"),
            NDRGrid(),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            PickupsSummaryGrid(),
            SizedBox(height: 20),
            SectionTitle("Pickups By Courier"),
            // SizedBox(height: 12),
            // ShipmentGrid(),
            // SizedBox(height: 20),
            // SectionTitle("NDR Details"),
            // NDRGrid(),
          ],
        );
      default:
        return Center(child: Text('Coming Soon'));
    }
  }
}
