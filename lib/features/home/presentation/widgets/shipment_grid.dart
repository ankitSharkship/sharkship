import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_tab_provider.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'shipment_stat_card.dart';

class ShipmentGrid extends ConsumerWidget {
  const ShipmentGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusState = ref.watch(orderStatusProvider);

    return statusState.when(
      loading: () => const _ShipmentGridSkeleton(),
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
                onTap: () {
                  switch (i) {
                    case 0:
                      ref.read(ordersTabProvider.notifier).setTab(0);
                      ref.read(bottomNavProvider.notifier).state = 1;
                      break;
                    case 1:
                      ref.read(shipmentTabProvider.notifier).setTab(0);
                      ref.read(bottomNavProvider.notifier).state = 2;
                    case 2:
                      ref.read(shipmentTabProvider.notifier).setTab(1);
                      ref.read(bottomNavProvider.notifier).state = 2;
                    case 3:
                      ref.read(shipmentTabProvider.notifier).setTab(2);
                      ref.read(bottomNavProvider.notifier).state = 2;
                    case 4:
                      ref.read(shipmentTabProvider.notifier).setTab(3);
                      ref.read(bottomNavProvider.notifier).state = 2;
                    case 5:
                      ref.read(shipmentTabProvider.notifier).setTab(4);
                      ref.read(bottomNavProvider.notifier).state = 2;
                    case 6:
                      ref.read(shipmentTabProvider.notifier).setTab(5);
                      ref.read(bottomNavProvider.notifier).state = 2;
                    default:
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _ShipmentGridSkeleton extends StatelessWidget {
  const _ShipmentGridSkeleton();

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
