import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/selected_orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/widgets/courier_priority_form.dart';
import 'package:sharkship/features/orders/presentation/widgets/address_picker_form.dart';

class OrdersHeader extends ConsumerWidget {
  const OrdersHeader({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Orders",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _showDatePicker(context),
                icon: const Icon(Icons.calendar_month, size: 22),
              ),
              IconButton(
                onPressed: () => _showActions(context, ref),
                icon: const Icon(Icons.build, size: 22),
              ),
              IconButton(
                onPressed: () => _showDatePicker(context),
                icon: const Icon(Icons.sort, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionsBottomDrawer(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(ordersTabProvider);
    final selectedOrders = ref.watch(selectedOrdersProvider(selectedTab));
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
            message: selectedOrders.message ?? "Exporting Orders",
            status: StatusType.loading,
          ),
        ),
      );

      try {
        final success = await ref
            .read(selectedOrdersProvider(selectedTab).notifier)
            .exportOrders();

        controller.close();

        if (success) {
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
          ref.invalidate(ordersProvider(selectedTab));
        } else {
          throw Exception("Backend returned failure");
        }
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

    Future<void> handleDelete(BuildContext context, WidgetRef ref) async {
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
            message: selectedOrders.message ?? "Deleting Orders",
            status: StatusType.deleteLoading,
          ),
        ),
      );

      try {
        final success = await ref
            .read(selectedOrdersProvider(selectedTab).notifier)
            .deleteSelected(null);

        controller.close();

        if (success) {
          messenger.showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: const StatusNotification(
                message: 'Orders deleted successfully',
                status: StatusType.success,
              ),
            ),
          );
          ref.invalidate(ordersProvider(selectedTab));
        } else {
          throw Exception("Backend returned failure");
        }
      } catch (e) {
        controller.close();
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: 'Failed to delete orders: ${e.toString()}',
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
                          label: "Sync",
                          icon: Icons.sync,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ActionButton(
                          label: "Select Courier",
                          icon: Icons.inventory_2_outlined,
                          color: Colors.green,
                          onTap: () {
                            Navigator.pop(context); // Close actions sheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const CourierPriorityForm(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: "Select Address",
                          icon: Icons.location_on_outlined,
                          color: Colors.teal,
                          onTap: () {
                            Navigator.pop(context); // Close actions sheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  const AddressPickerForm(onlyAddress: true),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: ActionButton(
                          label: "Ship Orders",
                          icon: Icons.local_shipping_outlined,
                          color: Colors.orange,
                          enabled: selectedOrders.selectedIds.isNotEmpty,
                          onTap: () {
                            Navigator.pop(context);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  AddressPickerForm(onlyAddress: false),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: "Export Orders",
                          icon: Icons.upload_outlined,
                          color: Colors.grey,
                          enabled: selectedOrders.selectedIds.isNotEmpty,
                          onTap: () {
                            exportOrders(context, ref);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ActionButton(
                          label: "Delete",
                          icon: Icons.delete_outline,
                          color: Colors.red,
                          enabled: selectedOrders.selectedIds.isNotEmpty,
                          onTap: () {
                            handleDelete(context, ref);
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
      label: Text(label, style: TextStyle(color: effectiveColor)),
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
