import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import '../state/create_orders_tab_provider.dart';

class CreateOrderTabbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(createOrdersTabProvider);

    return SizedBox(
      height: 48,
      width: double.infinity,
      child: Row(
        children: List.generate(orderTabs.length, (i) {
          final isActive = i == selected;

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(createOrdersTabProvider.notifier).setTab(i),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  orderTabs[i],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isActive ? Colors.blue : Colors.black54,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
