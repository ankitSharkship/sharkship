import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_filters_tab_provider.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_notifier.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_tab_provider.dart';

class TicketsHeader extends ConsumerWidget {
  const TicketsHeader({super.key});

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DateRangePickerModal(),
    );
  }

  void _showFilter(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _filterBottomDrawer(context, ref),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              SizedBox(width: 30),
              Text(
                "Help & Support",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _showDatePicker(context),
                icon: const Icon(Icons.calendar_month_outlined, size: 28),
              ),
              IconButton(
                onPressed: () => _showFilter(context, ref),
                icon: const Icon(Icons.filter_alt, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filterBottomDrawer(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 0),
      decoration: const BoxDecoration(
        color: Color(0xFFDCE6ED),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Row(
              children: const [
                Icon(Icons.filter_alt, size: 24),
                SizedBox(width: 12),
                Text(
                  "Filter Options",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(height: 1),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LeftTabs(),
                  const VerticalDivider(width: 1),
                  const Expanded(child: _RightContent()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final selectedTab = ref.read(ticketsTabProvider);
                      ref
                          .read(ticketsProvider(selectedTab).notifier)
                          .applyFilters();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        color: Color(0xFF0084FF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftTabs extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTicketsFilterTabProvider);

    return SingleChildScrollView(
      child: SizedBox(
        width: 140,
        child: Column(
          children: TicketsFilterTab.values.map((tab) {
            final isSelected = tab == selectedTab;

            return GestureDetector(
              onTap: () {
                ref.read(selectedTicketsFilterTabProvider.notifier).state = tab;
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                child: Text(
                  _getLabel(tab),
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getLabel(TicketsFilterTab tab) {
    switch (tab) {
      case TicketsFilterTab.categoryType:
        return "Category";
    }
  }
}

class _RightContent extends ConsumerWidget {
  const _RightContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTicketsFilterTabProvider);

    switch (selectedTab) {
      case TicketsFilterTab.categoryType:
        return _CategoryTypeView();
      default:
        return const SizedBox.shrink();
    }
  }
}

class _CategoryTypeView extends ConsumerWidget {
  final items = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Finance", value: "FINANCE"),
    RadioItems(displayName: "Technical", value: "TECHNICAL"),
    RadioItems(displayName: "Customer Support", value: "CUSTOMER_SUPPORT"),
    RadioItems(displayName: "Operations", value: "OPERATIONS"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(ticketsCategoryTypeFilterProvider);
    return _buildRadioList(
      ref,
      ticketsCategoryTypeFilterProvider,
      items,
      selected,
    );
  }
}

Widget _buildRadioList(
  WidgetRef ref,
  StateProvider<String?> provider,
  List<RadioItems> items,
  String? selected,
) {
  return ListView.builder(
    itemCount: items.length,
    padding: const EdgeInsets.symmetric(vertical: 8),
    itemBuilder: (context, index) {
      final item = items[index];
      return RadioListTile<String>(
        value: item.value,
        groupValue: selected ?? "All",
        title: Text(item.displayName, style: const TextStyle(fontSize: 14)),
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.blue,
        onChanged: (val) {
          ref.read(provider.notifier).state = val;
        },
      );
    },
  );
}

class RadioItems {
  final String displayName;
  final String value;
  RadioItems({required this.displayName, required this.value});
}
