import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/ndr_grid.dart';
import 'package:sharkship/features/home/presentation/widgets/shipment_grid.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            const DashboardHeader(),

            DashboardTabBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildTabContent(selectedTab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int tab) {
    /// Only overview implemented for now
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SummaryGrid(),
        SizedBox(height: 20),
        SectionTitle("Shipments Details"),
        SizedBox(height: 12),
        ShipmentGrid(),
        SizedBox(height: 20),
        SectionTitle("NDR Details"),
        NDRGrid(),
      ],
    );
  }
}
