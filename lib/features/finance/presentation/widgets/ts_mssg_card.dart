import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/features/finance/domain/entities/message_transaction_entity.dart';
import 'package:sharkship/features/finance/domain/entities/transaction_entity.dart';
import 'package:sharkship/shared/constants/colors.dart';

class TsMssgCard extends StatefulWidget {
  final MessageTransactionEntity transaction;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  final VoidCallback? onMoreTap;

  const TsMssgCard({
    super.key,
    required this.transaction,
    required this.isSelected,
    required this.onSelected,
    required this.onMoreTap,
  });

  @override
  State<TsMssgCard> createState() => _TsMssgCardState();
}

class _TsMssgCardState extends State<TsMssgCard> {
  bool isExpanded = false;

  @override
  void toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER ROW
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 12.0),
            child: Row(
              children: [
                Checkbox(
                  value: widget.isSelected,
                  onChanged: widget.onSelected,
                  activeColor: const Color(0xFF0084FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Order Id: ${widget.transaction.orderId ?? '-'}",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (widget.transaction.orderId != null) {
                            Clipboard.setData(
                              ClipboardData(
                                text: widget.transaction.orderId.toString(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'Order ID copied to clipboard',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }
                        },
                        child: Icon(
                          Icons.copy,
                          size: 14,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // BODY
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _row(
                  "Transaction Time",
                  DateFormat(
                        'dd MMMM yyyy, hh:mm a',
                      ).format(widget.transaction.createdAt) ??
                      '-',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _row(
                  "Processed",
                  "Sms sent: ${widget.transaction.processedCount} \n Charge: ${widget.transaction.processedTotalAmount}",
                  isMultiline: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _row(
                  "Shipped",
                  "Sms sent: ${widget.transaction.shippedCount} \n Charge: ${widget.transaction.shippedTotalAmount}",
                  isMultiline: true,
                ),
              ),

              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "NDR",
                              "Sms sent: ${widget.transaction.ndrCount} \n Charge: ${widget.transaction.ndrTotalAmount}",
                              isMultiline: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "Returned",
                              "Sms sent: ${widget.transaction.returnedCount} \n Charge: ${widget.transaction.returnedTotalAmount}",
                              isMultiline: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "OFD",
                              "Sms sent: ${widget.transaction.outForDeliveryCount} \n Charge: ${widget.transaction.outForDeliveryTotalAmount}",
                              isMultiline: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "Returned",
                              "Sms sent: ${widget.transaction.returnedCount} \n Charge: ${widget.transaction.returnedTotalAmount}",
                              isMultiline: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "Delivered",
                              "Sms sent: ${widget.transaction.deliveredCount} \n Charge: ${widget.transaction.deliveredTotalAmount}",
                              isMultiline: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "Channel",
                              "Sms sent: ${widget.transaction.channelCount} \n Charge: ${widget.transaction.channelTotalAmount}",
                              isMultiline: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "Manual",
                              "Sms sent: ${widget.transaction.manualCount} \n Charge: ${widget.transaction.manualTotalAmount}",
                              isMultiline: true,
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   child: _row(
                          //     "Total SMS Sent",
                          //     "Sms sent: ${widget.transaction.} \n Charge: ${widget.transaction.processedTotalAmount}",
                          //     isMultiline: true,
                          //   ),
                          // ),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   child: _row(
                          //     "Total Charge",
                          //     "Sms sent: ${widget.transaction.processedCount} \n Charge: ${widget.transaction.processedTotalAmount}",
                          //     isMultiline: true,
                          //   ),
                          // ),
                        ],
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 15),
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
                        color: Colors.black.withValues(alpha: 0.1),
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
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value, {
    bool isMultiline = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: isMultiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor ?? Colors.grey.shade600,
                fontWeight: valueColor != null
                    ? FontWeight.bold
                    : FontWeight.w500,
              ),
              textAlign: TextAlign.end,
              maxLines: isMultiline ? 3 : 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

}
