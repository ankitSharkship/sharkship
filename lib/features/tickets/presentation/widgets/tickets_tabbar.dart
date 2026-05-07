import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_tab_provider.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class TicketsTabbar extends ConsumerWidget {
  const TicketsTabbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(ticketsTabProvider);

    return SizedBox(
      height: 48,
      child: Row(
        children: List.generate(ticketsTabs.length, (i) {
          final isActive = i == selected;

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(ticketsTabProvider.notifier).setTab(i),
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
                  ticketsTabs[i],
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
