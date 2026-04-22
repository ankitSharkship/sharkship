import 'package:flutter/material.dart';

class MessagesMetricsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? count;
  final String? amount;

  const MessagesMetricsCard({
    super.key,
    required this.title,
    required this.icon,
    this.count,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          bottom: BorderSide(color: Colors.blue.shade700, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDDEAF6),
                ),
                child: Icon(icon, color: Colors.blue, size: 20),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  title,
                  softWrap: true,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// COUNT
          Text(
            "SMS: ${count ?? 0}",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          /// AMOUNT
          Text("Amount: ₹${amount ?? 0}", style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
