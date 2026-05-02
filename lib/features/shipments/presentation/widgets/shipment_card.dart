import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/orders/domain/entities/order_entity.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/constants/app_text_styles.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_notifier.dart';
import 'download_invoice_modal.dart';

class ShipmentCard extends ConsumerStatefulWidget {
  final OrderEntity order;
  final bool isSelected;
  final bool isFailed;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback? onDownloadTap;
  final VoidCallback? onMoreTap;
  final int tab;

  const ShipmentCard({
    super.key,
    required this.order,
    required this.isSelected,
    required this.onCheckboxChanged,
    this.isFailed = false,
    this.onDownloadTap,
    this.onMoreTap,
    required this.tab,
  });

  @override
  ConsumerState<ShipmentCard> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<ShipmentCard> {
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
    final tab = widget.tab;

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
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        if (tab < 3) ...[
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
                                Icons.sim_card_download,
                                color: Colors.greenAccent,
                              ),
                              onPressed: widget.onDownloadTap,
                              iconSize: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
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
                                case 'orderInvoice':
                                  if (mounted) {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DownloadInvoiceModal(
                                            orderIds: [order.id],
                                          ),
                                    );
                                  }
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
                                    ref.invalidate(shipmentProvider(tab));
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
                                case 'cancel':
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
                                      content: StatusNotification(
                                        message: "Canceling Order",
                                        status: StatusType.loading,
                                      ),
                                    ),
                                  );

                                  try {
                                    await ref
                                        .read(cancelOrdersUseCaseProvider)
                                        .execute([order.id]);
                                    controller.close();
                                    messenger.showSnackBar(
                                      SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: const StatusNotification(
                                          message:
                                              'Order canceled successfully',
                                          status: StatusType.success,
                                        ),
                                      ),
                                    );
                                    ref.invalidate(shipmentProvider(tab));
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
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'orderInvoice',
                                child: Row(
                                  children: const [
                                    Icon(Icons.description_outlined, size: 18),
                                    SizedBox(width: 10),
                                    Text('Order Invoice'),
                                  ],
                                ),
                              ),
                              if (tab < 3) ...[
                                PopupMenuItem(
                                  value: 'clone',
                                  child: Row(
                                    children: const [
                                      Icon(Icons.copy, size: 18),
                                      SizedBox(width: 10),
                                      Text('Clone Order'),
                                    ],
                                  ),
                                ),
                              ],
                              if (tab == 0) ...[
                                PopupMenuItem(
                                  value: 'cancel',
                                  child: Row(
                                    children:  [
                                      Icon(
                                        Icons.cancel_sharp,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Cancel Order',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: Colors.red,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Channel Id: ${order.channelOrderId ?? '-'}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
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
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
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

                        // Tooltip(
                        //   message: widget.isFailed
                        //       ? widget.order.errorMessage
                        //       : "", // empty → no tooltip
                        //   preferBelow: false,
                        //   waitDuration: const Duration(milliseconds: 300),
                        //   showDuration: const Duration(seconds: 2),
                        //   textStyle: const TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 12,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: Colors.black87,
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: 12,
                        //       vertical: 6,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       color: !widget.isFailed
                        //           ? const Color.fromARGB(255, 32, 112, 35)
                        //           : Colors.red,
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Icon(
                        //           !widget.isFailed
                        //               ? Icons.security_rounded
                        //               : Icons.warning,
                        //           color: ColorManager.white,
                        //           size: 15,
                        //         ),
                        //         const SizedBox(width: 4),
                        //         Text(
                        //           !widget.isFailed
                        //               ? "No RTO Risk"
                        //               : "Failed Due to",
                        //           style: const TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 11,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// DETAILS
              _middleSection(tab, isExpanded, order),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blue,
                          ),
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

  Widget _middleSection(int tab, bool isExpanded, OrderEntity order) {
    switch (tab) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("AWB", order.trackingId.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("AWB Date", order.awbGenerateAt.toString()),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Carrier", "${order.carrier}, ${order.courierType}"),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _row(
                            "Pickup Details",
                            "${order.pickupAddress.name ?? ""}, Addr: ${order.pickupAddress.addressLane1 ?? ""} ${order.pickupAddress.addressLane2 ?? ""} ${order.pickupAddress.landmark ?? ""} ${order.pickupAddress.city ?? ""} ${order.pickupAddress.state ?? ""} ${order.pickupAddress.pin ?? ""} Ph: ${order.pickupAddress.phoneNo ?? ""} ",
                            isMultiline: true,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("AWB", order.trackingId.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("In-Transit Date", order.lastEventAt.toString()),
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
                isMultiline: true,
                "Weight: ${order.productWeightInKg} Kg, ${order.shipmentLengthInCms} x ${order.shipmentWidthInCms} x ${order.shipmentHeightInCms}, Shipping Charge: ${order.shippingCharge} /-",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Carrier", "${order.carrier}, ${order.courierType}"),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _row(
                            "Pickup Details",
                            "${order.pickupAddress.name ?? ""}, Addr: ${order.pickupAddress.addressLane1 ?? ""} ${order.pickupAddress.addressLane2 ?? ""} ${order.pickupAddress.landmark ?? ""} ${order.pickupAddress.city ?? ""} ${order.pickupAddress.state ?? ""} ${order.pickupAddress.pin ?? ""} Ph: ${order.pickupAddress.phoneNo ?? ""} ",
                            isMultiline: true,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("AWB", order.trackingId.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("OFD", order.ofd.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row(
                "Expected Delivery Date",
                order.expectedDeliveryDateMin.toString(),
              ),
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
                isMultiline: true,
                "Weight: ${order.productWeightInKg} Kg, ${order.shipmentLengthInCms} x ${order.shipmentWidthInCms} x ${order.shipmentHeightInCms}, Shipping Charge: ${order.shippingCharge} /-",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Carrier", "${order.carrier}, ${order.courierType}"),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _row(
                            "Pickup Details",
                            "${order.pickupAddress.name ?? ""}, Addr: ${order.pickupAddress.addressLane1 ?? ""} ${order.pickupAddress.addressLane2 ?? ""} ${order.pickupAddress.landmark ?? ""} ${order.pickupAddress.city ?? ""} ${order.pickupAddress.state ?? ""} ${order.pickupAddress.pin ?? ""} Ph: ${order.pickupAddress.phoneNo ?? ""} ",
                            isMultiline: true,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        );
      case 3:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("AWB", order.trackingId.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Delivered Date", order.deliveryDate.toString()),
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
                isMultiline: true,
                "Weight: ${order.productWeightInKg} Kg, ${order.shipmentLengthInCms} x ${order.shipmentWidthInCms} x ${order.shipmentHeightInCms}, Shipping Charge: ${order.shippingCharge} /-",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Carrier", "${order.carrier}, ${order.courierType}"),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _row(
                            "Pickup Details",
                            "${order.pickupAddress.name ?? ""}, Addr: ${order.pickupAddress.addressLane1 ?? ""} ${order.pickupAddress.addressLane2 ?? ""} ${order.pickupAddress.landmark ?? ""} ${order.pickupAddress.city ?? ""} ${order.pickupAddress.state ?? ""} ${order.pickupAddress.pin ?? ""} Ph: ${order.pickupAddress.phoneNo ?? ""} ",
                            isMultiline: true,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        );
      case 4:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("AWB", order.trackingId.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("RTO Date", order.lastEventAt.toString()),
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
                isMultiline: true,
                "Weight: ${order.productWeightInKg} Kg, ${order.shipmentLengthInCms} x ${order.shipmentWidthInCms} x ${order.shipmentHeightInCms}, Shipping Charge: ${order.shippingCharge} /-",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Carrier", "${order.carrier}, ${order.courierType}"),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _row(
                            "Remarks",
                            "${order.remark ?? "-"}",
                            isMultiline: true,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        );
      case 5:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("AWB", order.trackingId.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Cancelled Date", order.lastEventAt.toString()),
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
                isMultiline: true,
                "Weight: ${order.productWeightInKg} Kg, ${order.shipmentLengthInCms} x ${order.shipmentWidthInCms} x ${order.shipmentHeightInCms}, Shipping Charge: ${order.shippingCharge} /-",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Carrier", "${order.carrier}, ${order.courierType}"),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _row(
                            "Pickup Details",
                            "${order.pickupAddress.name ?? ""}, Addr: ${order.pickupAddress.addressLane1 ?? ""} ${order.pickupAddress.addressLane2 ?? ""} ${order.pickupAddress.landmark ?? ""} ${order.pickupAddress.city ?? ""} ${order.pickupAddress.state ?? ""} ${order.pickupAddress.pin ?? ""} Ph: ${order.pickupAddress.phoneNo ?? ""} ",
                            isMultiline: true,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        );
      case 6:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("STATUS", order.status.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row(
                "AWB",
                order.trackingId.toString(),
                isMultiline: true,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row("Cancelled Date", order.lastEventAt.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row(
                "Product Details",
                "${order.productName} QTY: ${order.productQuantity}",
                isMultiline: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row(
                "Shipment Details",
                isMultiline: true,
                "Weight: ${order.productWeightInKg} Kg, ${order.shipmentLengthInCms} x ${order.shipmentWidthInCms} x ${order.shipmentHeightInCms}, Shipping Charge: ${order.shippingCharge} /-",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _row(
                "Carrier",
                "${order.carrier}, ${order.courierType}",
                isMultiline: true,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _row(
                            "Pickup Details",
                            "${order.pickupAddress.name ?? ""}, Addr: ${order.pickupAddress.addressLane1 ?? ""} ${order.pickupAddress.addressLane2 ?? ""} ${order.pickupAddress.landmark ?? ""} ${order.pickupAddress.city ?? ""} ${order.pickupAddress.state ?? ""} ${order.pickupAddress.pin ?? ""} Ph: ${order.pickupAddress.phoneNo ?? ""} ",
                            isMultiline: true,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        );

      default:
        return Column(
          children: [Center(child: Text('No Data available, contact Admin'))],
        );
    }
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
