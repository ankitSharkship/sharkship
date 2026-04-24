import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharkship/shared/constants/colors.dart';

import '../../domain/entities/tax_invoice_entity.dart';
import 'package:intl/intl.dart';

class InvoiceCard extends StatelessWidget {
  final TaxInvoiceEntity invoice;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  final VoidCallback? onPdfTap;
  final VoidCallback? onExcelTap;
  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.isSelected,
    required this.onSelected,
    this.onPdfTap,
    this.onExcelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const Divider(height: 1, color: Colors.black12),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    String short(String? text, [int max = 18]) {
      if (text == null) return 'N/A';
      return text.length > max ? '${text.substring(0, max)}...' : text;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isSelected,
                  onChanged: onSelected,
                  activeColor: const Color(0xFF0084FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          '${short(invoice.invoiceNo)}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            if (invoice.invoiceNo != null) {
                              Clipboard.setData(
                                ClipboardData(
                                  text: invoice.invoiceNo.toString(),
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
            ],
          ),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white, // Required for the shadow to be visible
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.15,
                      ), // Slightly darker for better elevation
                      blurRadius: 2, // Softness
                      spreadRadius: 1, // How much it grows
                      offset: const Offset(0, 1), // Pushes shadow down
                    ),
                  ],
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.greenAccent,
                  ),
                  onPressed: onPdfTap,
                  iconSize: 20,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white, // Required for the shadow to be visible
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.15,
                      ), // Slightly darker for better elevation
                      blurRadius: 2, // Softness
                      spreadRadius: 1, // How much it grows
                      offset: const Offset(0, 1), // Pushes shadow down
                    ),
                  ],
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.upload, color: ColorManager.black),
                  onPressed: onPdfTap,
                  iconSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Invoice Date',
              '${DateFormat('dd/MM/yyyy, hh:mm a').format(invoice.createdAt)}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Invoice Period',
              'From: ${invoice.month}',
              isMultiline: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Total Amount',
              '₹ ${invoice.totalAmount}',
              valueColor: ColorManager.primaryBlue,
            ),
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
                fontSize: 12,
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
