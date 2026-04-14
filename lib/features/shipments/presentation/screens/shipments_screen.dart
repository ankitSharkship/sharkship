import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/features/orders/domain/entities/orders_response_entity.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_skeleton.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';

import 'package:sharkship/features/shipments/presentation/state/selected_shipments_notifier.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_notifier.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_tab_provider.dart';
import 'package:sharkship/features/shipments/presentation/widgets/shipment_header.dart';
import 'package:sharkship/features/shipments/presentation/widgets/shipment_tabbar.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../widgets/shipment_card.dart';

class ShipmentsScreen extends ConsumerStatefulWidget {
  const ShipmentsScreen({super.key});
  @override
  ConsumerState<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends ConsumerState<ShipmentsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  void _loadMore() {
    final selectedTab = ref.read(shipmentTabProvider);

    final state = ref.read(shipmentProvider(selectedTab)).value;

    if (state == null) return;

    if (state.isLoadingMore) return;

    if (state.data == null) return;

    print(state.data!.orders.length);
    print(state.data!.totalCount);
    if (state.data!.orders.length >= state.data!.totalCount) return;
    print('Loading more not started4');
    ref.read(shipmentProvider(selectedTab).notifier).loadMore();
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _scrollController,
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
      data: (state) {
        final data =
            state.data ?? OrdersResponseEntity(totalCount: 0, orders: []);
        if (state.isFiltering) {
          return const Center(child: ThreeDotsLoader());
        }
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
                        value: selectedSihpmentsNotifier.isAllSelected(data),
                        onChanged: (value) {
                          selectedSihpmentsNotifier.toggleAll(data);
                        },
                      ),
                      const SizedBox(width: 4),
                      Text(
                        // isAllSelected ? "Unselect All" :
                        !selectedSihpmentsNotifier.isAllSelected(data)
                            ? "Select All"
                            : "Unselect All",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  // SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        data.orders.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < data.orders.length) {
                        final order = data.orders[index];
                        final isSelected = selectedShipments.selectedIds
                            .contains(order.id.toString());
                        return ShipmentCard(
                          order: order,
                          isSelected: isSelected,
                          onCheckboxChanged: (value) {
                            selectedSihpmentsNotifier.toggle(
                              order.id.toString(),
                            );
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
                      } else {
                        return _PaginationLoader(state);
                      }
                    },
                  ),
                ],
              ),
            ],
          ],
        );
      },
      error: (err, stack) => ErrorWidget(err),
      loading: () => Center(child: OrdersSkeletonList()),
    );
  }

  Widget _PaginationLoader(state) {
    if (!state.isLoadingMore) return const SizedBox();

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
