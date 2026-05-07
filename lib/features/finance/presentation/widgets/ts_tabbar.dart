import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/finance/presentation/state/ts_tab_provider.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class TsTabbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(tsTabProvider);

    return SizedBox(
      height: 48,
      child: Row(
        children: List.generate(tsTabs.length, (i) {
          final isActive = i == selected;

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(tsTabProvider.notifier).setTab(i),
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
                  tsTabs[i],
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

// color: const Color.fromARGB(255, 194, 238, 255),
