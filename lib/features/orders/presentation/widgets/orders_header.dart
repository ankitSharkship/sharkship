import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';
import 'package:sharkship/features/orders/presentation/state/courier_settings_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/filters_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';

import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/selected_orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/widgets/courier_priority_form.dart';
import 'package:sharkship/features/orders/presentation/widgets/address_picker_form.dart';
import 'package:sharkship/shared/widgets/error_card.dart';

import 'package:sharkship/shared/widgets/gradient_button.dart';

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
            "Orders",
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
      // padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 0),
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
                      final selectedTab = ref.read(ordersTabProvider);
                      ref
                          .read(ordersProvider(selectedTab).notifier)
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
    final selectedTab = ref.watch(selectedOrderFilterTabProvider);

    return SingleChildScrollView(
      child: SizedBox(
        width: 140,
        child: Column(
          children: OrderFilterTab.values.map((tab) {
            final isSelected = tab == selectedTab;

            return GestureDetector(
              onTap: () {
                ref.read(selectedOrderFilterTabProvider.notifier).state = tab;
              },
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 5,
                  top: 15,
                  bottom: 15,
                ),
                width: double.maxFinite,
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

  String _getLabel(OrderFilterTab tab) {
    switch (tab) {
      case OrderFilterTab.channels:
        return "Channels";
      case OrderFilterTab.courierServiceType:
        return "Courier Service Type";
      case OrderFilterTab.pickupAddress:
        return "Pickup Address";
      case OrderFilterTab.whatsappConfirmation:
        return "Whatsapp Confirmation";
      case OrderFilterTab.paymentType:
        return "Payment Type";
    }
  }
}

class _RightContent extends ConsumerWidget {
  const _RightContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedOrderFilterTabProvider);

    switch (selectedTab) {
      case OrderFilterTab.channels:
        return _ChannelsView();
      case OrderFilterTab.courierServiceType:
        return _CourierServiceTypeView();
      case OrderFilterTab.pickupAddress:
        return _PickupAddressView();
      case OrderFilterTab.whatsappConfirmation:
        return _WhatsappConfirmationView();
      case OrderFilterTab.paymentType:
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
    final selected = ref.watch(orderChannelFilterProvider);
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
            ref.read(orderChannelFilterProvider.notifier).state = val;
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
    final selected = ref.watch(orderCourierServiceTypeFilterProvider);

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
            ref.read(orderCourierServiceTypeFilterProvider.notifier).state =
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
    final selectedId = ref.watch(orderPickupAddressFilterProvider);

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
                  ref.read(orderPickupAddressFilterProvider.notifier).state =
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
                ref.read(orderPickupAddressFilterProvider.notifier).state = addr
                    .id
                    .toString();
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
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
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
                            child: const Text(
                              "Default",
                              style: TextStyle(
                                color: Color(0xFF22C55E),
                                fontSize: 10,
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
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    /// City + State + PIN
                    Text(
                      "${addr.city}, ${addr.state} - ${addr.pin}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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
          onRetry: () => ref.invalidate(courierSettingsProvider),
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
    final selected = ref.watch(orderWhatsappConfirmationFilterProvider);

    return ListView.builder(
      itemCount: types.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final type = types[index];
        return RadioListTile<String>(
          value: type.value,
          groupValue: selected ?? "All",
          title: Text(type.displayName, style: const TextStyle(fontSize: 14)),
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.blue,
          onChanged: (val) {
            ref.read(orderWhatsappConfirmationFilterProvider.notifier).state =
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
    final selected = ref.watch(orderPaymentTypeFilterProvider);

    return ListView.builder(
      itemCount: types.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final type = types[index];
        return RadioListTile<String>(
          value: type.value,
          groupValue: selected ?? "All",
          title: Text(type.displayName, style: const TextStyle(fontSize: 14)),
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.blue,
          onChanged: (val) {
            ref.read(orderPaymentTypeFilterProvider.notifier).state = val;
          },
        );
      },
    );
  }
}
