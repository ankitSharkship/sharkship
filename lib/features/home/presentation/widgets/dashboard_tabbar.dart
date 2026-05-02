import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_tab_provider.dart';

class DashboardTabBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(dashboardTabProvider);

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dashboardTabs.length,
        itemBuilder: (_, i) {
          final isActive = i == selected;

          return GestureDetector(
            onTap: () => ref.read(dashboardTabProvider.notifier).setTab(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.lightBlueBg,
                border: Border(
                  bottom: BorderSide(
                    color: isActive ? AppColors.primaryBlue : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                dashboardTabs[i],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isActive ? AppColors.primaryBlue : Colors.black54,
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

// color: const Color.fromARGB(255, 194, 238, 255),
