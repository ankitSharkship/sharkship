import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'shipment_stat_card.dart';

class ShipmentGrid extends ConsumerWidget {
  const ShipmentGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentStatusAsync = ref.watch(orderStatusProvider);

    return shipmentStatusAsync.when(
      loading: () => const ThreeDotsLoader(),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (summary) {
        final items = [
          (
            "To Be Processed",
            summary.getStatusCount("TO_BE_PROCESSED").toString(),
            Icons.sync,
          ),
          (
            "Ready to Ship",
            summary.getStatusCount("PROCESSED").toString(),
            Icons.check_box,
          ),
          (
            "In Transit",
            summary.getStatusCount("SHIPPED").toString(),
            Icons.local_shipping,
          ),
          (
            "Out For Delivery",
            summary.getStatusCount("OUT_FOR_DELIVERY").toString(),
            Icons.delivery_dining,
          ),
          (
            "Delivered",
            summary.getStatusCount("DELIVERED").toString(),
            Icons.inventory_2,
          ),
          (
            "RTO",
            summary.getStatusCount("RETURNED").toString(),
            Icons.assignment_return,
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
