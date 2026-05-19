import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/orders/presentation/screens/edit_order_screen.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/selected_orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import '../../domain/entities/order_entity.dart';

class OrderCard extends ConsumerStatefulWidget {
  final int tab;
  final OrderEntity order;
  final bool isSelected;
  final bool isFailed;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback? onTruckTap;
  final VoidCallback? onMoreTap;

  const OrderCard({
    super.key,
    required this.tab,
    required this.order,
    required this.isSelected,
    required this.onCheckboxChanged,
    this.isFailed = false,
    this.onTruckTap,
    this.onMoreTap,
  });

  @override
  ConsumerState<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<OrderCard> {
  bool isExpanded = false;

  @override
  void toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    bool noRTORisk =
        order.customer.mobileNo.length == 10 && order.customer.name != null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // TOP SECTION
          Column(
            children: [
              /// HEADER ROW
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      // A negative spreadRadius hides the shadow on the top and sides
                      spreadRadius: -1,
                      // Offset(x, y) - positive y moves it down
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Order Id: ${order.id}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Required for the shadow to be visible
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.15,
                                ), // Slightly darker for better elevation
                                blurRadius: 2, // Softness
                                spreadRadius: 1, // How much it grows
                                offset: const Offset(
                                  0,
                                  1,
                                ), // Pushes shadow down
                              ),
                            ],
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.local_shipping_outlined,
                              color: AppColors.primaryBlue,
                            ),
                            onPressed: widget.onTruckTap,
                            iconSize: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Required for the shadow to be visible
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.15,
                                ), // Slightly darker for better elevation
                                blurRadius: 2, // Softness
                                spreadRadius: 1, // How much it grows
                                offset: const Offset(
                                  0,
                                  1,
                                ), // Pushes shadow down
                              ),
                            ],
                          ),
                          child: PopupMenuButton<String>(
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.more_horiz,
                              color: AppColors.primaryBlue,
                            ),

                            position: PopupMenuPosition.under,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onSelected: (value) async {
                              switch (value) {
                                case 'edit':
                                  if (!mounted) break;
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EditOrderScreen(order: order),
                                    ),
                                  );
                                  break;
                                case 'clone':
                                  if (!mounted) break;
                                  final messenger = ScaffoldMessenger.of(
                                    context,
                                  );
                                  // 1. Show Loading
                                  final controller = messenger.showSnackBar(
                                    SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      duration: const Duration(days: 1),
                                      content: const StatusNotification(
                                        message: "Cloning Order",
                                        status: StatusType.loading,
                                      ),
                                    ),
                                  );

                                  try {
                                    await ref
                                        .read(cloneOrderUseCaseProvider)
                                        .execute(order.id);
                                    controller.close();
                                    messenger.showSnackBar(
                                      SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: const StatusNotification(
                                          message: 'Order cloned successfully',
                                          status: StatusType.success,
                                        ),
                                      ),
                                    );
                                    // Refresh the list to show the new cloned order
                                    // Usually cloned order appears in "Draft" or "Pending" but we refresh the current tab anyway
                                    final selectedTab = ref.read(
                                      ordersTabProvider,
                                    );
                                    ref.invalidate(ordersProvider(selectedTab));
                                  } catch (e) {
                                    controller.close();
                                    messenger.showSnackBar(
                                      SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: StatusNotification(
                                          message: 'Error: ${e.toString()}',
                                          status: StatusType.error,
                                        ),
                                      ),
                                    );
                                  }

                                  break;
                                case 'delete':
                                  final selectedTab = ref.read(
                                    ordersTabProvider,
                                  );
                                  final success = await ref
                                      .read(
                                        selectedOrdersProvider(
                                          selectedTab,
                                        ).notifier,
                                      )
                                      .deleteSelected(order.id);

                                  if (success && mounted) {
                                    ref.invalidate(ordersProvider(selectedTab));
                                  }
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 18),
                                    SizedBox(width: 10),
                                    Text(
                                      'Edit',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'clone',
                                child: Row(
                                  children: [
                                    Icon(Icons.copy, size: 18),
                                    SizedBox(width: 10),
                                    Text(
                                      'Clone Order',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Delete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// MAIN ROW
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// LEFT (LOGO)
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundColor: Colors.white,
                    //   child: const Icon(Icons.store),
                    // ),
                    Checkbox(
                      value: widget.isSelected,
                      onChanged: widget.onCheckboxChanged,
                    ),

                    const SizedBox(width: 7),

                    /// CENTER INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${order.channel}",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),

                          if (order.channelOrderId != "" &&
                              order.channelOrderId != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              "Channel Id: ${order.channelOrderId ?? '-'}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                          ],

                          Row(
                            children: [
                              _statusIcon(
                                icon: Icons.phone,
                                status: order.ivrRemark,
                              ),
                              const SizedBox(width: 8),
                              _statusIcon(
                                icon: Icons.chat,
                                status: order.whatsappRemark,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// RIGHT INFO
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "₹ ${order.productPrice}/-",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 3),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade100,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                order.paymentMode.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        Tooltip(
                          message: widget.isFailed
                              ? widget.order.errorMessage
                              : "", // empty → no tooltip
                          preferBelow: false,
                          waitDuration: const Duration(milliseconds: 300),
                          showDuration: const Duration(seconds: 2),
                          textStyle: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.white),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: !widget.isFailed
                                  ? const Color.fromARGB(255, 32, 112, 35)
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  !widget.isFailed
                                      ? Icons.security_rounded
                                      : Icons.warning,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  !widget.isFailed
                                      ? "No RTO Risk"
                                      : "Failed Due to",
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// DETAILS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _row("Order Date", order.createdAt.toIso8601String()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _row(
                  "Product Details",
                  "${order.productName} QTY: ${order.productQuantity}",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _row(
                  "Shipment Details",
                  "${order.productWeightInKg} (${order.shipmentLengthInCms} x ${order.shipmentWidthInCms} x ${order.shipmentHeightInCms} )",
                ),
              ),

              /// EXPANDED PART
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "Customer Details",
                              "${order.customer.name ?? ""}, Addr: ${order.deliveryAddress.addressLane1 ?? ""} ${order.deliveryAddress.addressLane2 ?? ""} ${order.deliveryAddress.landmark ?? ""} ${order.deliveryAddress.city ?? ""} ${order.deliveryAddress.state ?? ""} ${order.deliveryAddress.pin ?? ""} Ph: ${order.customer.mobileNo ?? ""} ",
                              isMultiline: true,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 15),

          /// FOOTER (SHOW MORE / LESS)
          GestureDetector(
            onTap: toggle,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    // Shrinks the shadow so it doesn't leak out the sides or bottom
                    spreadRadius: -1,
                    // A negative Y value moves the shadow UP
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isExpanded ? "Show Less" : "Show More",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: Colors.blue),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusIcon({required IconData icon, required String? status}) {
    if (status == null) return const SizedBox(); // hide completely

    Color bgColor;

    switch (status) {
      case 'PENDING':
        bgColor = const Color.fromARGB(255, 217, 172, 10);
        break;
      case 'VERIFIED':
        bgColor = Colors.green;
        break;
      default:
        bgColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(4), // tight → +2 radius feel
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }

  Widget _row(String title, String value, {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: isMultiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: isMultiline ? null : 1,
              overflow: isMultiline
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color.fromARGB(255, 101, 101, 101),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
