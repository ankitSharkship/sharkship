import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_tab_provider.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';
// import 'package:sharkship/shared/widgets/loader.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'shipment_stat_card.dart';

class NDRGrid extends ConsumerWidget {
  const NDRGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusState = ref.watch(ndrStatusProvider);

    return statusState.when(
      loading: () => const NDRGridSkeleton(),
      error: (err, stack) => ErrorCard(
        errMssg: "Failed to Load",
        onRetry: () {
          ref.invalidate(ndrStatusProvider);
        },
      ),
      data: (summary) {
        if (summary.countByNDRStatus.isEmpty) {
          return const SizedBox.shrink();
        }

        final group = summary.countByNDRStatus.first;

        final items = [
          (
            "NDR Order",
            group.totalNdrOrders.toString(),
            Icons.sync,
            HugeIcons.strokeRoundedNote01,
          ),
          (
            "Reattempted",
            group.totalReattempted.toString(),
            Icons.check_box,
            HugeIcons.strokeRoundedReload,
          ),
          (
            "NDR Delivered",
            group.totalDelivered.toString(),
            Icons.local_shipping,
            HugeIcons.strokeRoundedDeliveryTruck01,
          ),
          (
            "NDR Returned",
            group.totalReturned.toString(),
            Icons.delivery_dining,
            HugeIcons.strokeRoundedReturnRequest,
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
                icon2: items[i].$4,
                onTap: () {
                  context.push(Routes.NDR);
                  switch (i) {
                    case 0:
                      ref.read(ndrTabProvider.notifier).setTab(0);
                    case 1:
                      ref.read(ndrTabProvider.notifier).setTab(1);
                    case 2:
                      ref.read(ndrTabProvider.notifier).setTab(2);
                    case 3:
                      ref.read(ndrTabProvider.notifier).setTab(3);
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

class NDRGridSkeleton extends StatelessWidget {
  const NDRGridSkeleton();

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
