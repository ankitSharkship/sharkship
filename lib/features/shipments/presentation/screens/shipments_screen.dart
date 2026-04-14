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
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _loadMore() {
    final selectedTab = ref.read(shipmentTabProvider);

    final state = ref.read(shipmentProvider(selectedTab)).value;

    if (state == null) return;

    if (state.isLoadingMore) return;

    if (state.data == null) return;

    if (state.data!.orders.length >= state.data!.totalCount) return;
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
                child: _buildTabContent(selectedTab, ref, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int tab, WidgetRef ref, BuildContext context) {
    final shipments = ref.watch(shipmentProvider(tab));
    // final shipmentsState = ref.read(shipmentProvider(tab).notifier);
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

        if (data.totalCount == 0) {
          return ListView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [SizedBox(height: 100), _emptyState()],
          );
        }

        return ListView.builder(
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: true,
          cacheExtent: 300,
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: data.orders.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _header(data, selectedSihpmentsNotifier);
            }

            final adjustedIndex = index - 1;

            if (adjustedIndex >= data.orders.length) {
              if (state?.isLoadingMore ?? false) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            }

            final order = data.orders[adjustedIndex];

            final isSelected = selectedShipments.selectedIds.contains(
              order.id.toString(),
            );

            return RepaintBoundary(
              child: ShipmentCard(
                tab:tab,
                order: order,
                isSelected: isSelected,
                onCheckboxChanged: (_) {
                  selectedSihpmentsNotifier.toggle(order.id.toString());
                },
                onDownloadTap: selectedShipments.isLoading
                    ? null
                    : () {
                        handleDownloadShippingLabel(context, ref, order.id);
                      },
              ),
            );
          },
        );
      },
      error: (err, stack) => ErrorWidget(err),
      loading: () => const OrdersSkeletonList(),
    );
  }

  Widget _header(
    OrdersResponseEntity data,
    SelectedShipmentsNotifier selectedSihpmentsNotifier,
  ) {
    return Row(
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
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SvgPicture.asset(
            'assets/images/orders/no_orders.svg',
            height: 300,
            fit: BoxFit.fill,
            cacheColorFilter: true,
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
    );
  }

  // Widget _PaginationLoader(state) {
  //   if (!state.isLoadingMore) return const SizedBox();

  //   return const Padding(
  //     padding: EdgeInsets.symmetric(vertical: 16),
  //     child: Center(child: CircularProgressIndicator()),
  //   );
  // }
}
