import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';
import 'package:sharkship/features/shipments/presentation/state/selected_shipments_notifier.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_notifier.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_tab_provider.dart';
import 'package:sharkship/features/shipments/presentation/widgets/download_invoice_modal.dart';

class ShipmentHeader extends ConsumerWidget {
  const ShipmentHeader({super.key});

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
            "Shipment",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionsBottomDrawer(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(shipmentTabProvider);
    final selectedOrders = ref.watch(selectedShipmentsProvider(selectedTab));

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
              child: _buildActionButtons(context, ref, selectedTab),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    int selectedTab,
  ) {
    final selectedOrders = ref.watch(selectedShipmentsProvider(selectedTab));

    Future<void> handleDownloadShippingLabel(
      BuildContext context,
      WidgetRef ref,
    ) async {
      final messenger = ScaffoldMessenger.of(context);

      // 1. Show Loading
      final controller = messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: const Duration(days: 1),
          content: StatusNotification(
            message: "Downloading Shipping Label",
            status: StatusType.loading,
          ),
        ),
      );

      try {
        final success = await ref
            .read(selectedShipmentsProvider(selectedTab).notifier)
            .downloadLabels();

        controller.close();

        if (success) {
          messenger.showSnackBar(
            SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: const StatusNotification(
                message: 'Labels downloaded successfully',
                status: StatusType.success,
              ),
            ),
          );
        } else {
          final state = ref.read(selectedShipmentsProvider(selectedTab));
          throw Exception(state.message ?? "Failed to download labels");
        }
      } catch (e) {
        controller.close();
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: 'Error: ${e.toString().replaceAll('Exception: ', '')}',
              status: StatusType.error,
            ),
          ),
        );
      }
    }

    Future<void> handleGenerateManifest(
      BuildContext context,
      WidgetRef ref,
    ) async {
      final messenger = ScaffoldMessenger.of(context);

      // 1. Show Loading
      final controller = messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: const Duration(days: 1),
          content: StatusNotification(
            message: "Generating Manifest",
            status: StatusType.loading,
          ),
        ),
      );

      try {
        final ids = selectedOrders.selectedIds
            .map((e) => int.parse(e))
            .toList();
        await ref.read(generateManifestationUseCaseProvider).execute(ids);

        controller.close();

        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: const StatusNotification(
              message: 'Manifest generated successfully',
              status: StatusType.success,
            ),
          ),
        );

        // Clear selection after manifest generation
        ref.read(selectedShipmentsProvider(selectedTab).notifier).clear();
      } catch (e) {
        controller.close();
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: 'Error: ${e.toString().replaceAll('Exception: ', '')}',
              status: StatusType.error,
            ),
          ),
        );
      }
    }

    Future<void> handleCancelOrders(BuildContext context, WidgetRef ref) async {
      final messenger = ScaffoldMessenger.of(context);

      // 1. Show Loading
      final controller = messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: const Duration(days: 1),
          content: StatusNotification(
            message: "Canceling Orders",
            status: StatusType.loading,
          ),
        ),
      );

      try {
        final ids = selectedOrders.selectedIds
            .map((e) => int.parse(e))
            .toList();
        await ref.read(cancelOrdersUseCaseProvider).execute(ids);

        controller.close();

        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: const StatusNotification(
              message: 'Orders canceled successfully',
              status: StatusType.success,
            ),
          ),
        );

        // Clear selection and refresh list
        ref.read(selectedShipmentsProvider(selectedTab).notifier).clear();
        ref.invalidate(shipmentProvider(selectedTab));
      } catch (e) {
        controller.close();
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: 'Error: ${e.toString().replaceAll('Exception: ', '')}',
              status: StatusType.error,
            ),
          ),
        );
      }
    }

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
            .read(selectedShipmentsProvider(selectedTab).notifier)
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
          ref.invalidate(shipmentProvider(selectedTab));
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

    switch (selectedTab) {
      case 0 || 1 || 2:
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    label: "Shipping Label",
                    icon: Icons.sim_card_download,
                    enabled: selectedOrders.selectedIds.isNotEmpty,
                    color: Colors.teal,
                    onTap: () {
                      Navigator.pop(context);
                      handleDownloadShippingLabel(context, ref);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ActionButton(
                    label: "Manifest File",
                    icon: Icons.sim_card_download,
                    color: Colors.teal,
                    enabled: selectedOrders.selectedIds.isNotEmpty,
                    onTap: () {
                      Navigator.pop(context); // Close actions sheet
                      handleGenerateManifest(context, ref);
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
                    label: "Order Invoice",
                    icon: Icons.sim_card_download,
                    color: Colors.teal,
                    enabled: selectedOrders.selectedIds.isNotEmpty,
                    onTap: () {
                      Navigator.pop(context); // Close actions sheet
                      showDialog(
                        context: context,
                        builder: (context) => DownloadInvoiceModal(
                          orderIds: selectedOrders.selectedIds
                              .map((e) => int.parse(e))
                              .toList(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ActionButton(
                    label: "Export Orders",
                    icon: Icons.sim_card_download,
                    color: Colors.lightBlue,
                    enabled: selectedOrders.selectedIds.isNotEmpty,
                    onTap: () {
                      exportOrders(context, ref);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (selectedTab == 0) ...[
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: ActionButton(
                      label: "Cancel",
                      icon: Icons.cancel,
                      color: Colors.red,
                      enabled: selectedOrders.selectedIds.isNotEmpty,
                      onTap: () {
                        Navigator.pop(context); // Close actions sheet
                        handleCancelOrders(context, ref);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ],
        );

      default:
        return Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: ActionButton(
                    label: "Export Orders",
                    icon: Icons.sim_card_download,
                    color: Colors.lightBlue,
                    enabled: selectedOrders.selectedIds.isNotEmpty,
                    onTap: () {
                      exportOrders(context, ref);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }
}
