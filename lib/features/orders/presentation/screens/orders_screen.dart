import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/orders/presentation/state/courier_settings_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/selected_orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_card.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_tabbar.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(ordersTabProvider);
    Future<void> _onRefresh(int tab) async {
      ref.invalidate(ordersProvider(tab));
      ref.invalidate(courierSettingsProvider);
      // Optionally wait for the provider to complete if you want the spinner to stay
      return ref.read(ordersProvider(tab).future);
    }

    final courierSettings = ref.watch(courierSettingsProvider);

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const OrdersHeader(),
            OrdersTabbar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(selectedTab),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: _buildTabContent(selectedTab, ref),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [ColorManager.primaryBlue, ColorManager.secondaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () => {context.push(Routes.CREATE_ORDER)},
          child: const Icon(Icons.add, size: 35, color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTabContent(int tab, WidgetRef ref) {
    final orders = ref.watch(ordersProvider(tab));
    final ordersState = ref.read(ordersProvider(tab).notifier);
    final selectedOrders = ref.watch(selectedOrdersProvider(tab));
    final selectedOrdersNotifer = ref.read(
      selectedOrdersProvider(tab).notifier,
    );

    switch (tab) {
      case 0:
        return orders.when(
          data: (data) {
            return Column(
              children: [
                if (data.totalCount == 0) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SvgPicture.asset(
                          'assets/images/orders/no_orders.svg',
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No Orders Found',
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorManager.secondaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Start by creating a new order to manage and\n track it easily from this dashboard',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ] else ...[
                  Column(
                    children: [
                      // SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedOrdersNotifer.isAllSelected(
                              orders.value!,
                            ),
                            onChanged: (value) {
                              selectedOrdersNotifer.toggleAll(orders.value!);
                            },
                          ),
                          const SizedBox(width: 4),
                          Text(
                            // isAllSelected ? "Unselect All" :
                            !selectedOrdersNotifer.isAllSelected(orders.value!)
                                ? "Select All"
                                : "Unselect All",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      // SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.orders.length,
                        itemBuilder: (context, index) {
                          final order = data.orders[index];
                          final isSelected = selectedOrders.selectedIds
                              .contains(order.id.toString());
                          return OrderCard(
                            order: order,
                            isSelected: isSelected,
                            onCheckboxChanged: (value) {
                              selectedOrdersNotifer.toggle(order.id.toString());
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
          error: (err, stack) => Center(child: Text('Error: $err')),
          loading: () => Center(child: ThreeDotsLoader()),
        );

      case 1:
        return orders.when(
          data: (data) {
            return Column(
              children: [
                if (data.totalCount == 0) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SvgPicture.asset(
                          'assets/images/orders/no_orders.svg',
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No Orders Found',
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorManager.secondaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Start by creating a new order to manage and\n track it easily from this dashboard',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ] else ...[
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedOrdersNotifer.isAllSelected(
                              orders.value!,
                            ),
                            onChanged: (value) {
                              selectedOrdersNotifer.toggleAll(orders.value!);
                            },
                          ),
                          const SizedBox(width: 4),
                          Text(
                            // isAllSelected ? "Unselect All" :
                            !selectedOrdersNotifer.isAllSelected(orders.value!)
                                ? "Select All"
                                : "Unselect All",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.orders.length,
                        itemBuilder: (context, index) {
                          return OrderCard(
                            order: data.orders[index],
                            isSelected: false,
                            onCheckboxChanged: (value) {},
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
          error: (err, stack) => Center(child: Text('Error: $err')),
          loading: () => ThreeDotsLoader(),
        );
      default:
        return const Center(child: Text("Coming Soon"));
    }
  }
}
