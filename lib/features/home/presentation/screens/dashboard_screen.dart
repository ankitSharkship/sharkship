import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/ndr_grid.dart';
import 'package:sharkship/features/home/presentation/widgets/pickups_charts.dart';
import 'package:sharkship/features/home/presentation/widgets/ndr_stats_charts.dart';
import 'package:sharkship/features/home/presentation/widgets/rto_stats_charts.dart';
import 'package:sharkship/features/home/presentation/widgets/delivered_stats_charts.dart';
import 'package:sharkship/features/home/presentation/widgets/revenue_summary_grid.dart';
import 'package:sharkship/features/home/presentation/widgets/revenue_breakdown_table.dart';
import 'package:sharkship/features/home/presentation/widgets/revenue_stats_charts.dart';
import 'package:sharkship/features/home/presentation/widgets/shipment_grid.dart';
import 'package:sharkship/features/home/presentation/widgets/remittance_summary_grid.dart';
import 'package:sharkship/features/home/presentation/widgets/business_overview_widgets.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../providers/dashboard_tab_provider.dart';
import '../state/dashboard_notifier.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_tabbar.dart';
import '../widgets/section_title.dart';
import '../widgets/summary_grid.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(dashboardTabProvider);
    Future<void> _onRefresh(int selectedTab) async {
      switch (selectedTab) {
        case 0:
          ref.invalidate(todayMetricsProvider);
          ref.invalidate(orderStatusProvider);
          ref.invalidate(ndrStatusProvider);
          ref.invalidate(remittanceOverviewProvider);
          ref.invalidate(businessOverviewProvider);
          ref.invalidate(zoneDistributionProvider);
          ref.invalidate(mapOrdersProvider);
          break;
        case 1:
          ref.invalidate(courierPickupProvider);
        case 2:
          ref.invalidate(ndrStatusProvider);
          ref.invalidate(ndrDataProvider);
          ref.invalidate(datewiseNdrProvider);
        case 3:
          ref.invalidate(topRtoDataProvider);
          ref.invalidate(datewiseRtoProvider);
        case 4:
          ref.invalidate(topDeliveredDataProvider);
          ref.invalidate(codTrendProvider);
        case 5:
          ref.invalidate(orderRevenueProvider);
        default:
      }
    }

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const DashboardHeader(),
            DashboardTabBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(selectedTab),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildTabContent(selectedTab, ref),
                ),
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
        return SingleChildScrollView(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodayMetricsSummaryGrid(),
              SizedBox(height: 20),
              SectionTitle("Shipments Details"),
              SizedBox(height: 12),
              ShipmentGrid(),
              SizedBox(height: 20),
              SectionTitle("NDR Details"),
              SizedBox(height: 12),
              NDRGrid(),
              SizedBox(height: 24),
              SectionTitle("Remittance"),
              SizedBox(height: 12),
              RemittanceSummaryGrid(),
              SizedBox(height: 24),
              SectionTitle("Business Trends"),
              SizedBox(height: 12),
              BusinessOverviewChart(),
              SizedBox(height: 24),
              SectionTitle("Order Geography"),
              SizedBox(height: 12),
              ZoneDistributionOverviewChart(),
              SizedBox(height: 20),
              StateWiseOrdersTable(),
              SizedBox(height: 24),
            ],
          ),
        );
      case 1:
        return SingleChildScrollView(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PickupsSummaryGrid(),
              SizedBox(height: 20),
              PickupsCharts(),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NDRSummaryGrid(),
              SizedBox(height: 20),
              NDRStatsCharts(),
            ],
          ),
        );
      case 3:
        return SingleChildScrollView(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [RtoStatsCharts()],
          ),
        );
      case 4:
        return SingleChildScrollView(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [DeliveredStatsCharts()],
          ),
        );
      case 5:
        return Consumer(
          builder: (context, ref, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RevenueSummaryGrid(),
                  const SizedBox(height: 20),
                  const RevenueStatsCharts(),
                  const SizedBox(height: 20),
                  const RevenueBreakdownTable(),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      default:
        return const Center(child: Text('Coming Soon'));
    }
  }
}
