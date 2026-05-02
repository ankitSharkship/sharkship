import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/features/finance/domain/entities/transaction_entity.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: onSelected,
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
                          if (selectedTab == 0) ...[
                            Text(
                              "Order Id: ${transaction.orderId ?? 'N/A'}",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                            ),
                          ] else ...[
                            Text(
                              "Txn Id: ${short(transaction.txnId) ?? 'N/A'}",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
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
                              } else if (selectedTab == 1 &&
                                  transaction.txnId != null) {
                                Clipboard.setData(
                                  ClipboardData(text: transaction.txnId!),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      'Txn ID copied to clipboard',
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
                if (selectedTab == 1 && transaction.status != null) ...[
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 209, 242, 255),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryBlue,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      transaction.status ?? "",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const Divider(height: 1),

          // BODY
          _body(selectedTab, context),
        ],
      ),
    );
  }

  Widget _body(int tab, BuildContext context) {
    switch (tab) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              row("AWB", context, transaction.trackingId ?? '-'),
              row(
                "Date & Time",
                context,
                DateFormat(
                  'dd MMMM yyyy, hh:mm a',
                ).format(transaction.createdAt),
              ),
              row(
                "Wallet Type",
                context,
                transaction.affected.toUpperCase(),
                valueColor: Colors.blue.shade700,
              ),
              row("Shipping Charges", context, "₹${transaction.amount}"),
              row(
                "Order Description",
                context,
                transaction.description,
                isMultiline: true,
              ),
              row(
                "Journey Type",
                context,
                transaction.journeyType?.toUpperCase() ?? '-',
                valueColor:
                    (transaction.journeyType?.toUpperCase() == 'FORWARD')
                    ? Colors.green.shade700
                    : Colors.red.shade700,
              ),
              row(
                "Txn Type",
                context,
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
              row(
                "Date & Time",
                context,
                DateFormat(
                  'dd MMMM yyyy, hh:mm a',
                ).format(transaction.createdAt),
              ),
              row(
                "Wallet Type",
                context,
                transaction.affected.toUpperCase(),
                valueColor: Colors.blue.shade700,
              ),
              row(
                "Payment Gateway",
                context,
                transaction.paymentGateway ?? '-',
                valueColor: Colors.blue.shade700,
              ),
              row("Amount", context, "₹ ${transaction.amount}/-" ?? '-'),
              if (transaction.couponCode != "") ...[
                row("Coupon", context, transaction.couponCode ?? "Not Used"),
              ] else ...[
                row("Coupon", context, "NOT USED"),
              ],
              row("Order Description", context, transaction.description ?? '-'),

              if (transaction.remarks != "") ...[
                row(
                  "Admin Remarks",
                  context,
                  transaction.remarks ?? "No Remarks",
                ),
              ] else ...[
                row(
                  "Admin Remarks",
                  context,
                  "No Remarks",
                  valueColor: Colors.red.shade700,
                ),
              ],
              row("Txn Type", context, transaction.type.toUpperCase() ?? '-'),
            ],
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget row(
    String label,
    BuildContext context,
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
