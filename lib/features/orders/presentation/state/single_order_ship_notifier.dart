import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';
import '../../domain/entities/order_entity.dart';
import 'orders_provider.dart';
import 'orders_tab_provider.dart';

part 'single_order_ship_notifier.freezed.dart';
part 'single_order_ship_notifier.g.dart';

@freezed
abstract class SingleOrderShipState with _$SingleOrderShipState {
  const factory SingleOrderShipState({
    required int step,
    required OrderEntity order,
    required String length,
    required String width,
    required String height,
    required String weight,
    required bool isEditMode,
    required bool isSaving,
    String? error,
  }) = _SingleOrderShipState;
}

@riverpod
class SingleOrderShipNotifier extends _$SingleOrderShipNotifier {
  @override
  SingleOrderShipState build(OrderEntity initialOrder) {
    return SingleOrderShipState(
      step: 0,
      order: initialOrder,
      length: initialOrder.shipmentLengthInCms.toString(),
      width: initialOrder.shipmentWidthInCms.toString(),
      height: initialOrder.shipmentHeightInCms.toString(),
      weight: initialOrder.productWeightInKg,
      isEditMode: false,
      isSaving: false,
    );
  }

  void setStep(int step) {
    state = state.copyWith(step: step);
  }

  void nextStep() {
    state = state.copyWith(step: state.step + 1);
  }

  void previousStep() {
    if (state.step > 0) {
      state = state.copyWith(step: state.step - 1);
    }
  }

  void toggleEditMode() {
    if (state.isEditMode) {
      // Revert values to original order details on cancel
      state = state.copyWith(
        isEditMode: false,
        length: state.order.shipmentLengthInCms.toString(),
        width: state.order.shipmentWidthInCms.toString(),
        height: state.order.shipmentHeightInCms.toString(),
        weight: state.order.productWeightInKg,
      );
    } else {
      state = state.copyWith(isEditMode: true);
    }
  }

  void updateLength(String val) => state = state.copyWith(length: val);
  void updateWidth(String val) => state = state.copyWith(width: val);
  void updateHeight(String val) => state = state.copyWith(height: val);
  void updateWeight(String val) => state = state.copyWith(weight: val);

  Future<bool> saveDetails() async {
    final order = state.order;

    final payload = {
      "product_name": order.productName,
      "product_price": order.productPrice,
      "cod_amount": order.codAmount,
      "product_quantity": order.productQuantity,
      "product_category": order.lineItems.isNotEmpty
          ? order.lineItems.first.productCategory
          : "General",
      "product_sku_no": order.productSkuNo ?? "",
      "payment_mode": order.paymentMode,
      "client_orderId": order.clientOrderId ?? "",
      "channel_order_id": order.channelOrderId ?? "",
      "channel_store": order.channelStore ?? "",
      "service_type": order.serviceType,
      "lineItems": order.lineItems
          .map(
            (item) => {
              "product_name": item.name,
              "product_price": item.price,
              "product_quantity": item.quantity,
              "product_category": item.productCategory,
              "product_sku_no": item.sku ?? "",
            },
          )
          .toList(),
      "customer_name": order.customer.name,
      "customer_mobile_no": order.customer.mobileNo,
      "customer_email": "support@sharkship.in",
      "customer_address_lane1": order.deliveryAddress.addressLane1,
      "customer_address_lane2": order.deliveryAddress.addressLane2,
      "customer_address_landmark": order.deliveryAddress.landmark,
      "customer_address_pin": order.deliveryAddress.pin,
      "customer_address_city": order.deliveryAddress.city,
      "customer_address_state": order.deliveryAddress.state,
      "shipment_weight": state.weight,
      "shipment_length": int.tryParse(state.length) ?? 0,
      "shipment_width": int.tryParse(state.width) ?? 0,
      "shipment_height": int.tryParse(state.height) ?? 0,
    };

    state = state.copyWith(isSaving: true, error: null);

    try {
      final tabIndex = ref.read(ordersTabProvider);
      await ref.read(editOrderUseCaseProvider).execute(order.id, payload);

      // Invalidate the orders provider to refresh the list
      ref.invalidate(ordersProvider(tabIndex));

      state = state.copyWith(isSaving: false, isEditMode: false, step: 1);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      return false;
    }
  }
}
