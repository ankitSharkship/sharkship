import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/features/finance/domain/entities/message_transaction_entity.dart';
import 'package:sharkship/features/finance/domain/entities/remittance_entity.dart';
import 'package:sharkship/features/finance/domain/entities/transaction_entity.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class RsCard extends StatefulWidget {
  final RemittanceCycle remittance;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  final VoidCallback? onMoreTap;

  const RsCard({
    super.key,
    required this.remittance,
    required this.isSelected,
    required this.onSelected,
    required this.onMoreTap,
  });

  @override
  State<RsCard> createState() => _RsCardCardState();
}

class _RsCardCardState extends State<RsCard> {
  bool isExpanded = false;
  String short(String? text, [int max = 10]) {
    if (text == null) return 'N/A';
    return text.length > max ? '${text.substring(0, max)}...' : text;
  }

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
                  activeColor: AppColors.primaryBlue,
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
                        "Order Id: ${short(widget.remittance.id) ?? '-'}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (widget.remittance.id != null) {
                            Clipboard.setData(
                              ClipboardData(
                                text: widget.remittance.id.toString(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'Order ID copied to clipboard',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.black),
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
                  "Payment Date",
                  DateFormat(
                        'dd MMMM yyyy, hh:mm a',
                      ).format(widget.remittance.remittanceDate) ??
                      '-',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _row(
                  "COD Collected",
                  " ${widget.remittance.codCollected} ",
                  isMultiline: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _row(
                  "Deduction",
                  " ${widget.remittance.rtoDeduction}",
                  isMultiline: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _row(
                  "Remittance Amount",
                  " ${widget.remittance.netRemittanceAmount}",
                  isMultiline: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _row(
                  "Payment Reference",
                  " ${widget.remittance.fulfillmentReference}",
                  isMultiline: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _row(
                  "Status",
                  " ${widget.remittance.status.toUpperCase()}",
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
                              "Start Delivery Date",
                              DateFormat('dd MMMM yyyy, hh:mm a').format(
                                    widget.remittance.startDeliveryDate,
                                  ) ??
                                  '-',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "End Delivery Date",
                              DateFormat(
                                    'dd MMMM yyyy, hh:mm a',
                                  ).format(widget.remittance.endDeliveryDate) ??
                                  '-',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "Start Shipping Date",
                              DateFormat('dd MMMM yyyy, hh:mm a').format(
                                    widget.remittance.startShippingDate,
                                  ) ??
                                  '-',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _row(
                              "End Shipping Date",
                              DateFormat(
                                    'dd MMMM yyyy, hh:mm a',
                                  ).format(widget.remittance.endShippingDate) ??
                                  '-',
                            ),
                          ),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.primaryBlue,
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: valueColor ?? Colors.grey.shade600,
                    fontWeight:
                        valueColor != null ? FontWeight.bold : FontWeight.w500,
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
