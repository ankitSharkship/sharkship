import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/features/finance/domain/entities/transaction_entity.dart';
import 'package:sharkship/shared/constants/colors.dart';

class TsCard extends StatelessWidget {
  final TransactionEntity transaction;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  final int selectedTab;

  const TsCard({
    super.key,
    required this.transaction,
    required this.isSelected,
    required this.onSelected,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    String short(String? text, [int max = 10]) {
      if (text == null) return 'N/A';
      return text.length > max ? '${text.substring(0, max)}...' : text;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: onSelected,
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
                          if (selectedTab == 0) ...[
                            Text(
                              "Order Id: ${transaction.orderId ?? 'N/A'}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ] else ...[
                            Text(
                              "Txn Id: ${short(transaction.txnId) ?? 'N/A'}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              if (selectedTab == 0) {
                                if (transaction.orderId != null) {
                                  Clipboard.setData(
                                    ClipboardData(text: transaction.orderId!),
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
                              } else if (selectedTab == 1 &&
                                  transaction.txnId != null) {
                                Clipboard.setData(
                                  ClipboardData(text: transaction.txnId!),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      'Txn ID copied to clipboard',
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
                if (selectedTab == 1 && transaction.status != null) ...[
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 209, 242, 255),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ColorManager.primaryBlue,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      transaction.status ?? "",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const Divider(height: 1),

          // BODY
          _body(selectedTab),
        ],
      ),
    );
  }

  Widget _body(int tab) {
    switch (tab) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _row("AWB", transaction.trackingId ?? '-'),
              _row(
                "Date & Time",
                DateFormat(
                  'dd MMMM yyyy, hh:mm a',
                ).format(transaction.createdAt),
              ),
              _row(
                "Wallet Type",
                transaction.affected.toUpperCase(),
                valueColor: Colors.blue.shade700,
              ),
              _row("Shipping Charges", "₹${transaction.amount}"),
              _row(
                "Order Description",
                transaction.description,
                isMultiline: true,
              ),
              _row(
                "Journey Type",
                transaction.journeyType?.toUpperCase() ?? '-',
                valueColor:
                    (transaction.journeyType?.toUpperCase() == 'FORWARD')
                    ? Colors.green.shade700
                    : Colors.red.shade700,
              ),
              _row(
                "Txn Type",
                transaction.type.toUpperCase(),
                valueColor: Colors.blue.shade700,
              ),
            ],
          ),
        );
      case 1:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _row(
                "Date & Time",
                DateFormat(
                  'dd MMMM yyyy, hh:mm a',
                ).format(transaction.createdAt),
              ),
              _row(
                "Wallet Type",
                transaction.affected.toUpperCase(),
                valueColor: Colors.blue.shade700,
              ),
              _row(
                "Payment Gateway",
                transaction.paymentGateway ?? '-',
                valueColor: Colors.blue.shade700,
              ),
              _row("Amount", "₹ ${transaction.amount}/-" ?? '-'),
              if (transaction.couponCode != "") ...[
                _row("Coupon", transaction.couponCode ?? "Not Used"),
              ] else ...[
                _row("Coupon", "NOT USED"),
              ],
              _row("Order Description", transaction.description ?? '-'),

              if (transaction.remarks != "") ...[
                _row("Admin Remarks", transaction.remarks ?? "No Remarks"),
              ] else ...[
                _row(
                  "Admin Remarks",
                  "No Remarks",
                  valueColor: Colors.red.shade700,
                ),
              ],
              _row("Txn Type", transaction.type.toUpperCase() ?? '-'),
            ],
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _row(
    String label,
    String value, {
    bool isMultiline = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
