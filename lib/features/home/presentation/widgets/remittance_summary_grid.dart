import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sharkship/features/home/presentation/widgets/shipment_stat_card.dart';
import 'package:sharkship/features/home/presentation/widgets/summary_stat_card.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../state/dashboard_notifier.dart';

class RemittanceSummaryGrid extends ConsumerWidget {
  const RemittanceSummaryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remittanceState = ref.watch(remittanceOverviewProvider);

    return remittanceState.when(
      loading: () => const Center(child: _RemittanceSummaryGridSkeleton()),
      error: (error, _) => ErrorCard(
        errMssg: "Failed to Load",
        onRetry: () {
          ref.invalidate(remittanceOverviewProvider);
        },
      ),
      data: (data) {
        final items = [
          (
            "Remittance Paid",
            "₹ ${data.totalRemittancePaid}",
            Icons.account_balance_outlined,
            HugeIcons.strokeRoundedMoneyReceive02,
          ),
          (
            "COD Collected",
            "₹ ${data.totalCodCollected}",

            Icons.payments_outlined,
            HugeIcons.strokeRoundedCash02,
          ),
          (
            "Upcoming Remittance",
            "₹ ${data.upcomingRemittance}",

            Icons.schedule_outlined,
            HugeIcons.strokeRoundedCalendar03,
          ),
          (
            "Due Remittance",
            "₹ ${data.dueRemittance}",

            Icons.warning_amber_outlined,
            HugeIcons.strokeRoundedCalendarAdd01,
          ),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: 70,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ShipmentStatCard(
                  title: item.$1,
                  value: item.$2,
                  icon: item.$3,
                  icon2: item.$4,
                  onTap: () {
                    context.push(Routes.REMITTANCE_SUMMARY);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _RemittanceSummaryGridSkeleton extends StatelessWidget {
  const _RemittanceSummaryGridSkeleton();

  @override
  Widget build(BuildContext context) {
    final fakeItems = [
      ("Loading", "----", 0.0, Icons.inventory),
      ("Loading", "----", 0.0, Icons.show_chart),
      ("Loading", "----", 0.0, Icons.history),
      ("Loading", "----", 0.0, Icons.paid_outlined),
      ("Loading", "----", 0.0, Icons.history),
      ("Loading", "----", 0.0, Icons.paid_outlined),
    ];

    return Skeletonizer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fakeItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisExtent: 70,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, i) => ShipmentStatCard(
              title: fakeItems[i].$1,
              value: fakeItems[i].$2,
              icon: fakeItems[i].$4,
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
