import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/finance/presentation/state/sc_tab_provider.dart';
import 'package:sharkship/features/finance/presentation/state/shipping_rates_notifier.dart';
import 'package:sharkship/features/finance/presentation/widgets/sc_card.dart';
import 'package:sharkship/features/finance/presentation/widgets/sc_header.dart';
import 'package:sharkship/features/finance/presentation/widgets/sc_tabbar.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_skeleton.dart';
import 'package:sharkship/shared/constants/colors.dart';

class SellerChargesScreen extends ConsumerStatefulWidget {
  const SellerChargesScreen({super.key});
  @override
  ConsumerState<SellerChargesScreen> createState() =>
      _SellerChargesScreenState();
}

class _SellerChargesScreenState extends ConsumerState<SellerChargesScreen>
    with SingleTickerProviderStateMixin {
  final colors = [
    ColorManager.primaryBlue,
    ColorManager.secondaryBlue,
    ColorManager.lightBlue,
  ];
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(scTabProvider);
    final ratesAsync = ref.watch(shippingRatesProvider);
    Future<void> _onRefresh() async {
      ref.invalidate(shippingRatesProvider);
    }

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const ScHeader(),
            ScTabbar(),
            Expanded(
              child: ratesAsync.when(
                data: (rates) {
                  if (rates.isEmpty) {
                    return const Center(child: Text('No rates found'));
                  }
                  final forwardRates = rates
                      .where((rate) => rate.journeyType == 'FORWARD')
                      .toList();
                  final reverseRates = rates
                      .where((rate) => rate.journeyType == 'REVERSE')
                      .toList();
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          controller: _controller,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: colors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(text: 'Forward'),
                            Tab(text: 'RTO'),
                          ],
                        ),
                      ),

                      Expanded(
                        child: TabBarView(
                          controller: _controller,
                          children: [
                            RefreshIndicator(
                              onRefresh: _onRefresh,
                              child: ListView.builder(
                                itemCount: forwardRates.length,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 20,
                                ),
                                itemBuilder: (context, index) {
                                  return ScCard(
                                    rate: forwardRates[index],
                                    tab: selectedTab,
                                  );
                                },
                              ),
                            ),
                            RefreshIndicator(
                              onRefresh: _onRefresh,
                              child: ListView.builder(
                                itemCount: reverseRates.length,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 20,
                                ),
                                itemBuilder: (context, index) {
                                  return ScCard(
                                    rate: reverseRates[index],
                                    tab: selectedTab,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                loading: () =>
                    const Center(child: OrdersSkeletonList(itemCount: 4)),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
