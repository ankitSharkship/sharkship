import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_tab_provider.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class ShipmentTabbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(shipmentTabProvider);

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: shipmentTabs.length,
        itemBuilder: (_, i) {
          final isActive = i == selected;

          return GestureDetector(
            onTap: () => ref.read(shipmentTabProvider.notifier).setTab(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.lightBlueBg,
                border: Border(
                  bottom: BorderSide(
                    color: isActive ? Colors.blue : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                shipmentTabs[i],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isActive ? Colors.blue : Colors.black54,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
