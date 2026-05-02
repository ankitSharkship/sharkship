import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_tab_provider.dart';

class NdrTabbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(ndrTabProvider);

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ndrTabs.length,
        itemBuilder: (_, i) {
          final isActive = i == selected;

          return GestureDetector(
            onTap: () => ref.read(ndrTabProvider.notifier).setTab(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                ndrTabs[i],
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

// color: const Color.fromARGB(255, 194, 238, 255),
