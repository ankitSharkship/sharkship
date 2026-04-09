import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/colors.dart';
import '../../domain/entities/order_entity.dart';

class OrderCard extends StatefulWidget {
  final OrderEntity order;
  final bool isSelected;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback? onTruckTap;
  final VoidCallback? onMoreTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.isSelected,
    required this.onCheckboxChanged,
    this.onTruckTap,
    this.onMoreTap,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard>
    with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;

  @override
  bool get wantKeepAlive => true;

  void toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                              color: ColorManager.lightBlue,
                            ),
                            onPressed: widget.onMoreTap,
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
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.more_horiz,
                              color: ColorManager.lightBlue,
                            ),
                            onPressed: widget.onMoreTap,
                            iconSize: 20,
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Channel Id: ${order.channelOrderId ?? '-'}",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(Icons.phone, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Icon(Icons.chat, size: 18, color: Colors.red),
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
                              style: const TextStyle(
                                fontSize: 16,
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
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 32, 112, 35),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.security_rounded,
                                color: ColorManager.white,
                                size: 15,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "No RTO Risk",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
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
                      style: const TextStyle(color: Colors.blue),
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
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: ColorManager.black,
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
              style: TextStyle(color: const Color.fromARGB(255, 101, 101, 101)),
            ),
          ),
        ],
      ),
    );
  }
}
