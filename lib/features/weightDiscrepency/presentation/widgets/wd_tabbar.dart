import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/state/wd_tab_provider.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class WdTabbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(wdTabProvider);

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ndrTabs.length,
        itemBuilder: (_, i) {
          final isActive = i == selected;

          return GestureDetector(
            onTap: () => ref.read(wdTabProvider.notifier).setTab(i),
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
                ndrTabs[i],
                style: TextStyle(
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
