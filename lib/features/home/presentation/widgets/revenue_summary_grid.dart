import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/summary_stat_card.dart';

import 'package:skeletonizer/skeletonizer.dart';
import '../state/dashboard_notifier.dart';

class RevenueSummaryGrid extends ConsumerWidget {
  const RevenueSummaryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenueState = ref.watch(orderRevenueProvider);

    return revenueState.when(
      loading: () => const Center(child: _RevenueSummaryGridSkeleton()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (revenue) {
        final items = [
          (
            "Today's Orders",
            "${revenue.todayOrderCount}",
            revenue.orderCountPercentageIncrease,
            Icons.shopping_cart_outlined,
          ),
          (
            "Today's Revenue",
            "₹ ${revenue.todayRevenue}",
            revenue.revenuePercentageIncrease,
            Icons.payments_outlined,
          ),
          (
            "Total Orders",
            "${revenue.totalDeliveredOrders}",
            0.0, // Percentage change not available for total
            Icons.inventory_2_outlined,
          ),
          (
            "Total Revenue",
            "₹ ${revenue.totalRevenue}",
            0.0, // Percentage change not available for total
            Icons.account_balance_wallet_outlined,
          ),
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.4,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return SummaryStatCard(
              title: item.$1,
              value: item.$2,
              increase: item.$3,
              icon: item.$4,
              showGrowth: index < 2,
            );
          },
        );
      },
    );
  }
}

class _RevenueSummaryGridSkeleton extends StatelessWidget {
  const _RevenueSummaryGridSkeleton();

  @override
  Widget build(BuildContext context) {
    final fakeItems = [
      ("Loading", "----", 0.0, Icons.inventory),
      ("Loading", "----", 0.0, Icons.show_chart),
      ("Loading", "----", 0.0, Icons.history),
      ("Loading", "----", 0.0, Icons.paid_outlined),
    ];

    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: fakeItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 120,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, i) => SummaryStatCard(
          title: fakeItems[i].$1,
          value: fakeItems[i].$2,
          increase: fakeItems[i].$3,
          icon: fakeItems[i].$4,
          showGrowth: i < 2,
        ),
      ),
    );
  }
}
