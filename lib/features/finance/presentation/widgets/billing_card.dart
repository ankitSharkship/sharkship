import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharkship/features/finance/domain/entities/billing_cycle_entity.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

import '../../domain/entities/tax_invoice_entity.dart';
import 'package:intl/intl.dart';

class BillingCard extends StatelessWidget {
  final int count;
  final BillingCycleEntity billing;

  final VoidCallback? onPdfTap;

  const BillingCard({
    super.key,
    required this.billing,
    this.onPdfTap,
    required this.count,
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
          _buildBody(context),
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
                          'S.NO: ${(count + 1).toString()}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
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
                  icon: const Icon(Icons.download, color: Colors.greenAccent),
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

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Billing Start Date',
              context,
              '${DateFormat('dd/MM/yyyy, hh:mm a').format(billing.billingStartDate)}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Billing End Date',
              context,
              '${DateFormat('dd/MM/yyyy, hh:mm a').format(billing.billingEndDate)}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Credit Start Date',
              context,
              '${DateFormat('dd/MM/yyyy, hh:mm a').format(billing.creditStartDate)}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Credit End Date',
              context,
              '${DateFormat('dd/MM/yyyy, hh:mm a').format(billing.creditEndDate)}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Billing Status',
              context,
              '${billing.status}',
              isMultiline: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _row(
              'Total Amount',
              context,
              '₹ ${billing.amount}',
              valueColor: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    BuildContext context,
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
