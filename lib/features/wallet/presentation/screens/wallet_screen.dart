import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/wallet/presentation/widgets/coupon_card.dart';
import 'package:sharkship/features/wallet/presentation/widgets/payment_gateway_selector.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/wallet_notifier.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);
    final notifier = ref.read(walletProvider.notifier);

    if (walletState.isLoading) {
      return const Scaffold(body: Center(child: ThreeDotsLoader()));
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
        title: Text(
          'My Wallet',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => notifier.refreshBalance(),
            icon: const Icon(Icons.refresh, color: AppColors.primaryBlue),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            _buildBalanceCard(walletState.currentBalance),
            const SizedBox(height: 30),

            // Top Up Section
            Text(
              'Top Up Wallet',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            PaymentGatewaySelector(),
            const SizedBox(height: 15),
            _buildAmountInput(walletState, notifier),
            const SizedBox(height: 30),

            // Coupons Section
            Text(
              'Available Coupons',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildCouponsList(walletState, notifier),

            const SizedBox(height: 40),

            // Proceed Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: walletState.amount >= 200
                    ? () => notifier.initiatePayment()
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Proceed to Top Up',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(double balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Balance',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            '₹${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.security, color: Colors.white, size: 14),
                SizedBox(width: 5),
                Text(
                  '100% Secured',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput(WalletState state, WalletNotifier notifier) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final amount = double.tryParse(value) ?? 0.0;
          notifier.updateAmount(amount);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixText: '₹ ',
          prefixStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
          hintText: 'Enter amount',
        ),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildCouponsList(WalletState state, WalletNotifier notifier) {
    if (state.coupons.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text("No coupons available"),
      );
    }

    return SizedBox(
      height: 160,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.coupons.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final coupon = state.coupons[index];
          final isSelected = state.selectedCoupon?.id == coupon.id;

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: CouponTicketCard(
              coupon: coupon,
              isSelected: isSelected,
              onApply: () {
                if (isSelected) {
                  notifier.removeCoupon();
                } else {
                  notifier.validateAndApplyCoupon(coupon);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
