import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/shipment_stat_card.dart';
import 'package:sharkship/features/home/presentation/widgets/summary_stat_card.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/dashboard_notifier.dart';

class RemittanceSummaryGrid extends ConsumerWidget {
  const RemittanceSummaryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remittanceState = ref.watch(remittanceOverviewProvider);

    return remittanceState.when(
      loading: () => const Center(child: ThreeDotsLoader()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (data) {
        final items = [
          (
            "Remittance Paid",
            "₹ ${data.totalRemittancePaid}",
            Icons.account_balance_outlined,
          ),
          (
            "COD Collected",
            "₹ ${data.totalCodCollected}",

            Icons.payments_outlined,
          ),
          (
            "Upcoming Remittance",
            "₹ ${data.upcomingRemittance}",

            Icons.schedule_outlined,
          ),
          (
            "Due Remittance",
            "₹ ${data.dueRemittance}",

            Icons.warning_amber_outlined,
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
                  onTap: () {
                    _comingSoon(context);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void _comingSoon(BuildContext context) {
    GlobalPopups.showAlert(
      context: context,
      title: "Coming Soon",
      body: "This feature is coming soon",
      confirmText: "OK",
      onConfirm: () => Navigator.pop(context),
    );
  }
}
