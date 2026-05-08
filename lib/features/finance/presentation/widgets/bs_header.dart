import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sharkship/features/finance/presentation/state/billing_summary_notifier.dart';
import 'package:sharkship/features/finance/presentation/state/bs_filters_tab_provider.dart';
import 'package:sharkship/features/finance/presentation/state/finance_filter_models.dart';

import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';

class BsHeader extends ConsumerWidget {
  const BsHeader({super.key});

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DateRangePickerModal(),
    );
  }

  void _showActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _actionsBottomDrawer(context, ref),
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
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 28),
              ),
              Text(
                "Billing Summary",
                // style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                style: Theme.of(context).textTheme.headlineSmall,
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
                onPressed: () => _showActions(context, ref),
                icon: const Icon(Icons.build, size: 22),
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

      decoration: const BoxDecoration(
        color: Color(0xFFDCE6ED),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // title
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
              child: Row(
                children: const [
                  Icon(Icons.filter_alt, size: 24),
                  SizedBox(width: 12),
                  Text(
                    "Filter Options",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
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
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                      ref
                          .read(billingSummaryProvider.notifier)
                          .fetchBillingCycles();
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

  Widget _actionsBottomDrawer(BuildContext context, WidgetRef ref) {
    Future<void> syncOrders(BuildContext context, WidgetRef ref) async {
      Navigator.pop(context);

      final messenger = ScaffoldMessenger.of(context);

      // 1. Show Loading
      final controller = messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: const Duration(days: 1),
          content: StatusNotification(
            message: "Syncing...",
            status: StatusType.loading,
          ),
        ),
      );

      try {
        final result = await ref
            .read(billingSummaryProvider.notifier)
            .sync();
        controller.close();

        result.fold(
          (l) => messenger.showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: StatusNotification(
                message: 'Failed to sync: ${l.message}',
                status: StatusType.error,
              ),
            ),
          ),
          (r) => messenger.showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: const StatusNotification(
                message: 'Billing cycle updated',
                status: StatusType.success,
              ),
            ),
          ),
        );
      } catch (e) {
        controller.close();
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: 'Failed to export transactions: ${e.toString()}',
              status: StatusType.error,
            ),
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFDCE6ED),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // title
            Row(
              children: const [
                Icon(Icons.build, size: 23),
                SizedBox(width: 8),
                Text(
                  "Actions",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // card container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: "Sync Orders",
                          icon: Icons.upload_outlined,
                          color: Colors.grey,
                          onTap: () {
                            syncOrders(context, ref);
                          },
                        ),
                      ),
                    ],
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

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool enabled;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = enabled ? color : color.withValues(alpha: 0.3);

    return OutlinedButton.icon(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, color: effectiveColor),
      label: Text(label, style: TextStyle(color: effectiveColor)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: effectiveColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}

class _LeftTabs extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedBsFilterTabProvider);

    return SingleChildScrollView(
      child: SizedBox(
        width: 140,
        child: Column(
          children: BsFilterTab.values.map((tab) {
            final isSelected = tab == selectedTab;

            return GestureDetector(
              onTap: () {
                ref.read(selectedBsFilterTabProvider.notifier).state = tab;
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  left: 20,
                  right: 5,
                ),
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

  String _getLabel(BsFilterTab tab) {
    switch (tab) {
      case BsFilterTab.dateQuery:
        return "Data Filter";
      case BsFilterTab.status:
        return "Status";
    }
  }
}

class _RightContent extends ConsumerWidget {
  const _RightContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedBsFilterTabProvider);

    switch (selectedTab) {
      case BsFilterTab.dateQuery:
        return _DataFilterView();
      case BsFilterTab.status:
        return _StatusFilteriew();
    }
  }
}

class _DataFilterView extends ConsumerWidget {
  final items = [
    RadioItems(displayName: "By Billing Date", value: "BILLING"),
    RadioItems(displayName: "By Credit Date", value: "CREDIT"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(bsDateQueryTypeFilterProvider);
    return _buildRadioList(ref, bsDateQueryTypeFilterProvider, items, selected);
  }
}

class _StatusFilteriew extends ConsumerWidget {
  final items = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Billing", value: "BILLING"),
    RadioItems(displayName: "Paid", value: "PAID"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(bsStatusTypeFilterProvider);
    return _buildRadioList(ref, bsStatusTypeFilterProvider, items, selected);
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

enum StatusType { loading, success, error, deleteLoading }

class StatusNotification extends StatelessWidget {
  final String message;
  final StatusType status;
  const StatusNotification({required this.message, required this.status});

  @override
  Widget build(BuildContext context) {
    Color themeColor;
    Color bgColor;
    Widget icon;

    switch (status) {
      case StatusType.loading:
        themeColor = Colors.blue.shade700;
        bgColor = Colors.blue.shade50;
        icon = CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
        );
        break;
      case StatusType.success:
        themeColor = const Color(0xFF2E7D32);
        bgColor = const Color(0xFFF0F9F4);
        icon = Icon(Icons.check_circle, color: themeColor, size: 28);
        break;
      case StatusType.error:
        themeColor = Colors.red.shade800;
        bgColor = Colors.red.shade50;
        icon = Icon(Icons.error, color: themeColor, size: 28);
        break;
      case StatusType.deleteLoading:
        themeColor = Colors.red.shade800;
        bgColor = Colors.red.shade50;
        icon = CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
        );
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          SizedBox(width: 24, height: 24, child: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: themeColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
