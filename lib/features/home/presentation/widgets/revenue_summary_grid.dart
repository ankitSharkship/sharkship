import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/summary_stat_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/dashboard_notifier.dart';
import 'summary_grid.dart'; // Reuse SummaryCard

class RevenueSummaryGrid extends ConsumerWidget {
  const RevenueSummaryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenueState = ref.watch(orderRevenueProvider);

    return revenueState.when(
      loading: () => const Center(child: ThreeDotsLoader()),
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
