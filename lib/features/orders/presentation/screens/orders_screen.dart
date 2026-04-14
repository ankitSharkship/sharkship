import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/orders/domain/entities/order_entity.dart';
import 'package:sharkship/features/orders/domain/entities/orders_response_entity.dart';
import 'package:sharkship/features/orders/presentation/state/courier_settings_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/selected_orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/single_order_ship_notifier.dart';
import 'package:sharkship/features/orders/presentation/widgets/address_picker_form.dart';
import 'package:sharkship/features/orders/presentation/widgets/courier_priority_form.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_card.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_tabbar.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
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

    void _openSingleShipModal(OrderEntity order, BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => SingleOrderShipForm(order: order),
      );
      return;
    }

    switch (tab) {
      case 0:
        return orders.when(
          data: (state) {
            final data =
                state?.data ?? OrdersResponseEntity(totalCount: 0, orders: []);
            if (state?.isFiltering ?? false) {
              return const Center(child: ThreeDotsLoader());
            }

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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedOrdersNotifer.isAllSelected(data),
                            onChanged: (value) {
                              selectedOrdersNotifer.toggleAll(data);
                            },
                          ),
                          const SizedBox(width: 4),
                          Text(
                            !selectedOrdersNotifer.isAllSelected(data)
                                ? "Select All"
                                : "Unselect All",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                            onTruckTap: () {
                              _openSingleShipModal(order, context);
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
          data: (state) {
            final data =
                state?.data ?? OrdersResponseEntity(totalCount: 0, orders: []);
            if (state?.isFiltering ?? false) {
              return const Center(child: ThreeDotsLoader());
            }

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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedOrdersNotifer.isAllSelected(data),
                            onChanged: (value) {
                              selectedOrdersNotifer.toggleAll(data);
                            },
                          ),
                          const SizedBox(width: 4),
                          Text(
                            !selectedOrdersNotifer.isAllSelected(data)
                                ? "Select All"
                                : "Unselect All",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.orders.length,
                        itemBuilder: (context, index) {
                          return OrderCard(
                            order: data.orders[index],
                            isSelected: false,
                            isFailed: true,
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

class SingleOrderShipForm extends ConsumerWidget {
  final OrderEntity order;
  const SingleOrderShipForm({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(singleOrderShipProvider(order));
    final notifier = ref.read(singleOrderShipProvider(order).notifier);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: _buildStepContent(context, state, notifier),
    );
  }

  Widget _buildStepContent(
    BuildContext context,
    SingleOrderShipState state,
    SingleOrderShipNotifier notifier,
  ) {
    switch (state.step) {
      case 0:
        return _changeShipmentDetails(context, state, notifier);
      case 1:
        return AddressPickerForm(onlyAddress: false, onNext: notifier.nextStep);
      case 2:
        return CourierPriorityForm(orderId: order.id, onlyCourier: false);
      default:
        return const ThreeDotsLoader();
    }
  }

  Widget _changeShipmentDetails(
    BuildContext context,
    SingleOrderShipState state,
    SingleOrderShipNotifier notifier,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Change Shipment Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              child: Column(
                children: [
                  _input(
                    key: ValueKey('len_${state.isEditMode}'),
                    label: 'Length (cm)*',
                    hint: "",
                    initialValue: state.length,
                    onChanged: notifier.updateLength,
                    isEnabled: state.isEditMode,
                  ),
                  _input(
                    key: ValueKey('wid_${state.isEditMode}'),
                    label: 'Width (cm)*',
                    hint: "",
                    initialValue: state.width,
                    onChanged: notifier.updateWidth,
                    isEnabled: state.isEditMode,
                  ),
                  _input(
                    key: ValueKey('hei_${state.isEditMode}'),
                    label: 'Height (cm)*',
                    hint: "",
                    initialValue: state.height,
                    onChanged: notifier.updateHeight,
                    isEnabled: state.isEditMode,
                  ),
                  _input(
                    key: ValueKey('wei_${state.isEditMode}'),
                    label: 'Weight (kg)*',
                    hint: "",
                    initialValue: state.weight,
                    onChanged: notifier.updateWeight,
                    isEnabled: state.isEditMode,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: notifier.toggleEditMode,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            backgroundColor: const Color(
                              0xFF0EA5E9,
                            ).withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            !state.isEditMode ? "Edit" : "Cancel",
                            style: const TextStyle(
                              color: Color(0xFF0EA5E9),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GradientButton(
                          onTap: () async {
                            if (state.isEditMode) {
                              final success = await notifier.saveDetails();
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Shipment details updated successfully",
                                    ),
                                  ),
                                );
                              } else if (state.error != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Failed to update shipment details: ${state.error}",
                                    ),
                                  ),
                                );
                              }
                            } else {
                              notifier.nextStep();
                            }
                          },
                          text: state.isEditMode ? "Save & Next" : "Next",
                          child: state.isSaving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _input({
    Key? key,
    required String label,
    required String hint,
    String? initialValue,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    TextInputType keyboard = TextInputType.text,
    bool obscureText = false,
    bool isEnabled = true,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          validator: validator,
          keyboardType: keyboard,
          obscureText: obscureText,
          onChanged: onChanged,
          readOnly: !isEnabled,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF1E88C8)),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
