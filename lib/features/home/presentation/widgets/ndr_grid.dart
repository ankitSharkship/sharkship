import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'shipment_stat_card.dart';

class NDRGrid extends ConsumerWidget {
  const NDRGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusState = ref.watch(ndrStatusProvider);

    return statusState.when(
      loading: () => const ThreeDotsLoader(),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (summary) {
        if (summary.countByNDRStatus.isEmpty) {
          return const SizedBox.shrink();
        }

        final group = summary.countByNDRStatus.first;

        final items = [
          ("NDR Order", group.totalNdrOrders.toString(), Icons.sync),
          ("Reattempted", group.totalReattempted.toString(), Icons.check_box),
          (
            "NDR Delivered",
            group.totalDelivered.toString(),
            Icons.local_shipping,
          ),
          (
            "NDR Returned",
            group.totalReturned.toString(),
            Icons.delivery_dining,
          ),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: 70,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, i) => ShipmentStatCard(
                title: items[i].$1,
                value: items[i].$2,
                icon: items[i].$3,
              ),
            );
          },
        );
      },
    );
  }
}
