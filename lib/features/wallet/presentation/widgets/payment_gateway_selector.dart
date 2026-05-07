import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/wallet/presentation/state/wallet_notifier.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class PaymentGatewaySelector extends ConsumerStatefulWidget {
  const PaymentGatewaySelector({super.key});

  @override
  ConsumerState<PaymentGatewaySelector> createState() =>
      _PaymentGatewaySelectorState();
}

class _PaymentGatewaySelectorState
    extends ConsumerState<PaymentGatewaySelector> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walletProvider);
    final notifier = ref.read(walletProvider.notifier);
    // final gateways = ["CASHFREE", "RAZORPAY", "PHONEPE", "PAYU"];
    final gateways = ["RAZORPAY", "CASHFREE"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: gateways.map((g) {
          final active = g == state.selectedPaymentGateway;

          return GestureDetector(
            onTap: () {
              if (state.selectedPaymentGateway == null ||
                  state.selectedPaymentGateway == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "No Payment gateway selected",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
                return;
              }
              notifier.setPaymentGateway(g);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: active ? Colors.blue : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: Text(
                g,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.blue : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
