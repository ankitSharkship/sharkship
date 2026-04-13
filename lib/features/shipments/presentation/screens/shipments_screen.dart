import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';

import 'package:sharkship/features/shipments/presentation/state/selected_shipments_notifier.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_notifier.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_tab_provider.dart';
import 'package:sharkship/features/shipments/presentation/widgets/shipment_header.dart';
import 'package:sharkship/features/shipments/presentation/widgets/shipment_tabbar.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../widgets/shipment_card.dart';

class ShipmentsScreen extends ConsumerWidget {
  const ShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(shipmentTabProvider);
    Future<void> _onRefresh(int tab) async {
      ref.invalidate(shipmentProvider(tab));
      // Optionally wait for the provider to complete if you want the spinner to stay
      return ref.read(shipmentProvider(tab).future);
    }

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const ShipmentHeader(),
            ShipmentTabbar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(selectedTab),
                backgroundColor: ColorManager.lightBlue,
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),

                  padding: const EdgeInsets.all(16),
                  child: _buildTabContent(selectedTab, ref, context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int tab, WidgetRef ref, BuildContext context) {
    final shipments = ref.watch(shipmentProvider(tab));
    final shipmentsState = ref.read(shipmentProvider(tab).notifier);
    final selectedShipments = ref.watch(selectedShipmentsProvider(tab));
    final selectedSihpmentsNotifier = ref.read(
      selectedShipmentsProvider(tab).notifier,
    );

    Future<void> handleDownloadShippingLabel(
      BuildContext context,
      WidgetRef ref, [
      int? orderId,
    ]) async {
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
            .read(selectedShipmentsProvider(tab).notifier)
            .downloadLabels(orderId != null ? [orderId] : null);

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
          final state = ref.read(selectedShipmentsProvider(tab));
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

    return shipments.when(
      data: (data) {
        return Column(
          children: [
            if (data.totalCount == 0) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: SvgPicture.asset(
                      'assets/images/orders/no_orders.svg',
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No Orders Found',
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorManager.secondaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const Text(
                  //   'Start by creating a new order to manage and\n track it easily from this dashboard',
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ] else ...[
              Column(
                children: [
                  // SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: selectedSihpmentsNotifier.isAllSelected(
                          shipments.value!,
                        ),
                        onChanged: (value) {
                          selectedSihpmentsNotifier.toggleAll(shipments.value!);
                        },
                      ),
                      const SizedBox(width: 4),
                      Text(
                        // isAllSelected ? "Unselect All" :
                        !selectedSihpmentsNotifier.isAllSelected(
                              shipments.value!,
                            )
                            ? "Select All"
                            : "Unselect All",
                        style: const TextStyle(fontSize: 14),
                      ),
                      // const Spacer(),
                      // if (selectedShipments.selectedIds.isNotEmpty)
                      //   ElevatedButton.icon(
                      //     onPressed: selectedShipments.isLoading ? null : () {
                      //       handleDownloadShippingLabel(context, ref, [s.id]);
                      //     },
                      //     icon: const Icon(Icons.download, size: 18),
                      //     label: Text(
                      //       "Download Labels (${selectedShipments.selectedIds.length})",
                      //       style: const TextStyle(fontSize: 12),
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: ColorManager.primaryBlue,
                      //       foregroundColor: Colors.white,
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 12,
                      //         vertical: 8,
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                  // SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.orders.length,
                    itemBuilder: (context, index) {
                      final order = data.orders[index];
                      final isSelected = selectedShipments.selectedIds.contains(
                        order.id.toString(),
                      );
                      // switch (tab) {
                      return ShipmentCard(
                        order: order,
                        isSelected: isSelected,
                        onCheckboxChanged: (value) {
                          selectedSihpmentsNotifier.toggle(order.id.toString());
                        },
                        onDownloadTap: selectedShipments.isLoading
                            ? null
                            : () {
                                handleDownloadShippingLabel(
                                  context,
                                  ref,
                                  order.id,
                                );
                              },
                      );
                    },
                  ),
                ],
              ),
            ],
          ],
        );
      },
      error: (err, stack) => ErrorWidget(err),
      loading: () => Center(child: ThreeDotsLoader()),
    );
  }
}
