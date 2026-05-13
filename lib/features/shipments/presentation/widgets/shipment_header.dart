import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/shared/constants/app_text_styles.dart';
import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';
import 'package:sharkship/features/orders/presentation/state/courier_settings_notifier.dart';

import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';
import 'package:sharkship/features/shipments/presentation/state/selected_shipments_notifier.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_filters_tab_provider.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_notifier.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_tab_provider.dart';
import 'package:sharkship/features/shipments/presentation/widgets/download_invoice_modal.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Shipment",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
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
              padding: const EdgeInsets.only(top: 8, left: 20),
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
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final selectedTab = ref.read(shipmentTabProvider);
                      ref
                          .read(shipmentProvider(selectedTab).notifier)
                          .applyFilters();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Apply",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
              children: [
                const Icon(Icons.build, size: 23),
                const SizedBox(width: 8),
                Text(
                  "Actions",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
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

class _LeftTabs extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedShipmentFilterTabProvider);

    return SingleChildScrollView(
      child: SizedBox(
        width: 140,
        child: Column(
          children: ShipmentFilterTab.values.map((tab) {
            final isSelected = tab == selectedTab;

            return GestureDetector(
              onTap: () {
                ref.read(selectedShipmentFilterTabProvider.notifier).state =
                    tab;
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.fromLTRB(20, 12, 10, 12),
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

  String _getLabel(ShipmentFilterTab tab) {
    switch (tab) {
      case ShipmentFilterTab.channels:
        return "Channels";
      case ShipmentFilterTab.courierServiceType:
        return "Courier Service Type";
      case ShipmentFilterTab.pickupAddress:
        return "Pickup Address";
      case ShipmentFilterTab.whatsappConfirmation:
        return "Whatsapp Confirmation";
      case ShipmentFilterTab.paymentType:
        return "Payment Type";
    }
  }
}

class _RightContent extends ConsumerWidget {
  const _RightContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedShipmentFilterTabProvider);

    switch (selectedTab) {
      case ShipmentFilterTab.channels:
        return _ChannelsView();
      case ShipmentFilterTab.courierServiceType:
        return _CourierServiceTypeView();
      case ShipmentFilterTab.pickupAddress:
        return _PickupAddressView();
      case ShipmentFilterTab.whatsappConfirmation:
        return _WhatsappConfirmationView();
      case ShipmentFilterTab.paymentType:
        return _PaymentTypeView();
    }
  }
}

class _ChannelsView extends ConsumerWidget {
  final channels = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Manual", value: "MANUAL"),
    RadioItems(displayName: "Shopify", value: "SHOPIFY"),
    RadioItems(displayName: "Open Cart", value: "OPENCART"),
    RadioItems(displayName: "Woo Commerce", value: "WOOCOMMERCE"),
    RadioItems(displayName: "WIX", value: "WIX"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(shipmentChannelFilterProvider);
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
            ref.read(shipmentChannelFilterProvider.notifier).state = val;
          },
        );
      },
    );
  }
}

class _CourierServiceTypeView extends ConsumerWidget {
  final courierType = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "PAN INDIA", value: "PAN_INDIA"),
    RadioItems(displayName: "SDD", value: "SDD"),
    RadioItems(displayName: "NDD", value: "NDD"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(shipmentCourierServiceTypeFilterProvider);

    return ListView.builder(
      itemCount: courierType.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final channel = courierType[index];
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
            ref.read(shipmentCourierServiceTypeFilterProvider.notifier).state =
                val;
          },
        );
      },
    );
  }
}

class _PickupAddressView extends ConsumerWidget {
  const _PickupAddressView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(courierSettingsProvider);
    final selectedId = ref.watch(shipmentPickupAddressFilterProvider);

    return state.when(
      data: (data) {
        final addresses = data.addresses;

        if (addresses == null || addresses.isEmpty) {
          return Center(
            child: Text(
              "No addresses found",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: addresses.length + 1, // +1 for "All"
          itemBuilder: (context, index) {
            /// ✅ ALL OPTION
            if (index == 0) {
              final isSelected = selectedId == null;

              return GestureDetector(
                onTap: () {
                  ref.read(shipmentPickupAddressFilterProvider.notifier).state =
                      null;
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.blue : const Color(0xFFE8EEF5),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "All",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }

            /// ✅ NORMAL ITEMS (shift index)
            final addr = addresses[index - 1];
            final isSelected = selectedId == addr.id.toString();

            return GestureDetector(
              onTap: () {
                ref.read(shipmentPickupAddressFilterProvider.notifier).state =
                    addr.id.toString();
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? Colors.blue : const Color(0xFFE8EEF5),
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name + Default Tag
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            addr.name ?? "Unnamed Address",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (addr.isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF22C55E).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "Default",
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: const Color(0xFF22C55E),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// Address line
                    Text(
                      "${addr.addressLane1}, ${addr.addressLane2 ?? ''}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),

                    /// City + State + PIN
                    Text(
                      "${addr.city}, ${addr.state} - ${addr.pin}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: ErrorCard(
          onRetry: () => ref.read(courierSettingsProvider),
          errMssg: "Something went wrong",
        ),
      ),
    );
  }
}

class _WhatsappConfirmationView extends ConsumerWidget {
  final types = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Yes", value: "YES"),
    RadioItems(displayName: "No", value: "NO"),
    RadioItems(displayName: "Pending", value: "PENDING"),
    RadioItems(displayName: "Address Update", value: "ADDRESS_UPDATE"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(shipmentWhatsappConfirmationFilterProvider);

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
            ref
                    .read(shipmentWhatsappConfirmationFilterProvider.notifier)
                    .state =
                val;
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
    final selected = ref.watch(shipmentPaymentTypeFilterProvider);

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
            ref.read(shipmentPaymentTypeFilterProvider.notifier).state = val;
          },
        );
      },
    );
  }
}
