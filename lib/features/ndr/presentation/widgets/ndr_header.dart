import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_filters_tab_provider.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_notifier.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_tab_provider.dart';
import 'package:sharkship/features/ndr/presentation/state/selected_ndr_notifier.dart';

class NdrHeader extends ConsumerWidget {
  const NdrHeader({super.key});

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
                "NDR Overview",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
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
                children: [
                  Icon(Icons.filter_alt, size: 24),
                  SizedBox(width: 12),
                  Text(
                    "Filter Options",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final selectedTab = ref.read(ndrTabProvider);
                      ref
                          .read(ndrProvider(selectedTab).notifier)
                          .applyFilters();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Apply",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF0084FF),
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
    final selectedTab = ref.watch(ndrTabProvider);
    final selectedNdrs = ref.watch(selectedNdrProvider(selectedTab));
    // final selectedOrderNotifer = ref.read(
    //   selectedOrdersProvider(selectedTab).notifier,
    // );
    Future<void> exportOrders(BuildContext context, WidgetRef ref) async {
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
            message: selectedNdrs.message ?? "Exporting NDRs",
            status: StatusType.loading,
          ),
        ),
      );

      try {
        await ref
            .read(selectedNdrProvider(selectedTab).notifier)
            .exportOrders(selectedTab);

        controller.close();

        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: const StatusNotification(
              message: 'Orders Exported successfully',
              status: StatusType.success,
            ),
          ),
        );
        ref.invalidate(selectedNdrProvider(selectedTab));
      } catch (e) {
        controller.close();
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: 'Failed to export orders: ${e.toString()}',
              status: StatusType.error,
            ),
          ),
        );
      }
    }

    Future<void> ndrReattempt(BuildContext context, WidgetRef ref) async {
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7)),
        helpText: 'Select Re-attempt Date',
        confirmText: 'Confirm',
        cancelText: 'Cancel',
      );

      if (selectedDate == null) return;

      if (!context.mounted) return;
      Navigator.pop(context); // Close Actions drawer

      final messenger = ScaffoldMessenger.of(context);

      // 1. Show Loading
      final controller = messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: const Duration(days: 1),
          content: StatusNotification(
            message: selectedNdrs.message ?? "Scheduling Re-attempts",
            status: StatusType.loading,
          ),
        ),
      );

      try {
        final success = await ref
            .read(selectedNdrProvider(selectedTab).notifier)
            .reattempt(selectedDate.toUtc().toIso8601String());

        controller.close();

        if (success) {
          messenger.showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: const StatusNotification(
                message: 'Re-attempts scheduled successfully',
                status: StatusType.success,
              ),
            ),
          );
          ref.invalidate(ndrProvider(selectedTab));
        } else {
          throw Exception("No orders selected or request failed");
        }
      } catch (e) {
        controller.close();
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: 'Failed to schedule re-attempts: ${e.toString()}',
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
              children: [
                Icon(Icons.build, size: 23),
                SizedBox(width: 8),
                Text(
                  "Actions",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
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
                    color: Colors.black.withOpacity(0.05),
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
                          label: "Export Orders",
                          icon: Icons.upload_outlined,
                          color: Colors.grey,
                          enabled: selectedNdrs.selectedIds.isNotEmpty,
                          onTap: () {
                            exportOrders(context, ref);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ActionButton(
                          label: "Re Attempt",
                          icon: Icons.restart_alt_outlined,
                          color: Colors.red,
                          enabled: selectedNdrs.selectedIds.isNotEmpty,
                          onTap: () {
                            ndrReattempt(context, ref);
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
    required this.label,
    required this.icon,
    required this.color,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = enabled ? color : color.withOpacity(0.3);

    return OutlinedButton.icon(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, color: effectiveColor),
      label: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: effectiveColor),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: effectiveColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}

enum StatusType { loading, success, error, deleteLoading }

class StatusNotification extends StatelessWidget {
  final String message;
  final StatusType status;
  const StatusNotification({required this.message, required this.status});

  @override
  Widget build(BuildContext context) {
    // Determine colors based on status
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
        border: Border.all(color: themeColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          SizedBox(width: 24, height: 24, child: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: themeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftTabs extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedNdrFilterTabProvider);

    return SingleChildScrollView(
      child: SizedBox(
        width: 140,
        child: Column(
          children: NdrFilterTab.values.map((tab) {
            final isSelected = tab == selectedTab;

            return GestureDetector(
              onTap: () {
                ref.read(selectedNdrFilterTabProvider.notifier).state = tab;
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.fromLTRB(20, 16, 5, 16),
                color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                child: Text(
                  _getLabel(tab),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

  String _getLabel(NdrFilterTab tab) {
    switch (tab) {
      case NdrFilterTab.carrier:
        return "Courier";
      case NdrFilterTab.paymentType:
        return "Payment Type";
    }
  }
}

class _RightContent extends ConsumerWidget {
  const _RightContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedNdrFilterTabProvider);

    switch (selectedTab) {
      case NdrFilterTab.carrier:
        return _CarrierView();
      case NdrFilterTab.paymentType:
        return _PaymentTypeView();
    }
  }
}

class _CarrierView extends ConsumerWidget {
  final channels = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Amazon ATS", value: "Amazon_ATS"),
    RadioItems(displayName: "Shadowfax", value: "Shadowfax"),
    RadioItems(displayName: "XpressBees", value: "XpressBees"),
    RadioItems(displayName: "Shree Maruti", value: "Shree_Maruti"),
    RadioItems(displayName: "Blitz", value: "Blitz"),
    RadioItems(displayName: "Ekart", value: "Ekart"),
    RadioItems(displayName: "Delhivery", value: "Delhivery"),
    RadioItems(displayName: "BlueDart", value: "BlueDart"),
    RadioItems(displayName: "Pikendel", value: "Pikndel"),
    RadioItems(displayName: "Dtdc", value: "Dtdc"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(ndrCarrierFilterProvider);
    return ListView.builder(
      itemCount: channels.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final channel = channels[index];
        return RadioListTile<String>(
          value: channel.value,
          groupValue: selected ?? "All",
          title: Text(
            channel.displayName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.blue,
          onChanged: (val) {
            ref.read(ndrCarrierFilterProvider.notifier).state = val;
          },
        );
      },
    );
  }
}

class _PaymentTypeView extends ConsumerWidget {
  final types = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Cod", value: "COD"),
    RadioItems(displayName: "Prepaid", value: "PREPAID"),
    RadioItems(displayName: "Partial COD", value: "PARTIAL_COD"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(ndrPaymentTypeFilterProvider);

    return ListView.builder(
      itemCount: types.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final type = types[index];
        return RadioListTile<String>(
          value: type.value,
          groupValue: selected ?? "All",
          title: Text(
            type.displayName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.blue,
          onChanged: (val) {
            ref.read(ndrPaymentTypeFilterProvider.notifier).state = val;
          },
        );
      },
    );
  }
}
