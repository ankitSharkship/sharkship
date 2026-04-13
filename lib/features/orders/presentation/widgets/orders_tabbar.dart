import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/shared/constants/colors.dart';
import '../state/orders_tab_provider.dart';

class OrdersTabbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(ordersTabProvider);

    return SizedBox(
      height: 48,
      width: double.infinity,
      child: Row(
        children: List.generate(orderTabs.length, (i) {
          final isActive = i == selected;

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(ordersTabProvider.notifier).setTab(i),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 194, 238, 255),
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  orderTabs[i],
                  style: TextStyle(
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
