import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/line_item_entity.dart';
import 'orders_provider.dart';
import 'orders_tab_provider.dart';

part 'single_order_ship_notifier.freezed.dart';
part 'single_order_ship_notifier.g.dart';

// ---------------------------------------------------------------------------
// Mutable line item used inside the edit form (no id for new items)
// ---------------------------------------------------------------------------
class EditLineItem {
  final int? id;
  String productName;
  String productPrice;
  String productQuantity;
  String? sku;
  String? taxRate;
  String productCategory;

  EditLineItem({
    this.id,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    this.sku,
    this.taxRate,
    required this.productCategory,
  });

  EditLineItem copyWith({
    String? productName,
    String? productPrice,
    String? productQuantity,
    String? sku,
    String? taxRate,
    String? productCategory,
  }) {
    return EditLineItem(
      id: id,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productQuantity: productQuantity ?? this.productQuantity,
      sku: sku ?? this.sku,
      taxRate: taxRate ?? this.taxRate,
      productCategory: productCategory ?? this.productCategory,
    );
  }

  Map<String, dynamic> toPayload() => {
    if (id != null) 'id': id,
    'product_name': productName,
    'product_price': num.tryParse(productPrice) ?? 0,
    'product_quantity': int.tryParse(productQuantity) ?? 0,
    'product_category': productCategory,
    'product_sku_no': sku ?? '',
    'tax_rate': taxRate,
  };
}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------
@freezed
abstract class SingleOrderShipState with _$SingleOrderShipState {
  const factory SingleOrderShipState({
    required int step,
    required OrderEntity order,

    // --- Shipment dimensions (shared with ship-flow) ---
    required String length,
    required String width,
    required String height,
    required String weight,
    required bool isEditMode,
    required bool isSaving,
    String? error,

    // --- Editable customer fields ---
    required String customerName,
    required String customerMobile,
    required String addressLane1,
    required String addressLane2,
    required String landmark,
    required String pin,
    required String city,
    required String state,

    // --- Editable order fields ---
    required String paymentMode,
    required String serviceType,
    required String codAmount,
    required String clientOrderId,

    // --- Editable line items ---
    required List<EditLineItem> lineItems,
  }) = _SingleOrderShipState;
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------
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

      // Customer
      customerName: initialOrder.customer.name ?? '',
      customerMobile: initialOrder.customer.mobileNo,
      addressLane1: initialOrder.deliveryAddress.addressLane1 ?? "",
      addressLane2: initialOrder.deliveryAddress.addressLane2 ?? "",
      landmark: initialOrder.deliveryAddress.landmark ?? '',
      pin: initialOrder.deliveryAddress.pin.toString(),
      city: initialOrder.deliveryAddress.city ?? "",
      state: initialOrder.deliveryAddress.state ?? "",

      // Order
      paymentMode: initialOrder.paymentMode,
      serviceType: initialOrder.serviceType,
      codAmount: initialOrder.codAmount.toString(),
      clientOrderId: initialOrder.clientOrderId ?? '',

      // Line items – seed from entity
      lineItems: initialOrder.lineItems.map(_fromEntity).toList(),
    );
  }

  static EditLineItem _fromEntity(LineItemEntity e) => EditLineItem(
    id: e.id,
    productName: e.name,
    productPrice: e.price.toString(),
    productQuantity: e.quantity.toString(),
    sku: e.sku,
    taxRate: e.taxRate,
    productCategory: e.productCategory,
  );

  // --- Ship-flow navigation ---
  void setStep(int step) => state = state.copyWith(step: step);
  void nextStep() => state = state.copyWith(step: state.step + 1);
  void previousStep() {
    if (state.step > 0) state = state.copyWith(step: state.step - 1);
  }

  void toggleEditMode() {
    if (state.isEditMode) {
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

  // --- Customer field updaters ---
  void updateCustomerName(String v) => state = state.copyWith(customerName: v);
  void updateCustomerMobile(String v) =>
      state = state.copyWith(customerMobile: v);
  void updateAddressLane1(String v) => state = state.copyWith(addressLane1: v);
  void updateAddressLane2(String v) => state = state.copyWith(addressLane2: v);
  void updateLandmark(String v) => state = state.copyWith(landmark: v);
  void updatePin(String v) => state = state.copyWith(pin: v);
  void updateCity(String v) => state = state.copyWith(city: v);
  void updateStateField(String v) => state = state.copyWith(state: v);

  // --- Order field updaters ---
  void updatePaymentMode(String v) => state = state.copyWith(paymentMode: v);
  void updateServiceType(String v) => state = state.copyWith(serviceType: v);
  void updateCodAmount(String v) => state = state.copyWith(codAmount: v);
  void updateClientOrderId(String v) =>
      state = state.copyWith(clientOrderId: v);

  // --- Line item management ---
  void addLineItem() {
    final items = List<EditLineItem>.from(state.lineItems)
      ..add(
        EditLineItem(
          productName: '',
          productPrice: '',
          productQuantity: '1',
          productCategory: '',
        ),
      );
    state = state.copyWith(lineItems: items);
  }

  void removeLineItem(int index) {
    final items = List<EditLineItem>.from(state.lineItems)..removeAt(index);
    state = state.copyWith(lineItems: items);
  }

  /// Permanently deletes an existing line item via API and updates state
  Future<bool> deleteLineItemPermanently(int id, int index) async {
    state = state.copyWith(isSaving: true, error: null);
    try {
      final success = await ref.read(deleteLineItemUseCaseProvider).execute(id);
      if (success) {
        removeLineItem(index);
        state = state.copyWith(isSaving: false);
        return true;
      } else {
        state = state.copyWith(isSaving: false, error: 'Failed to delete item');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      return false;
    }
  }

  void updateLineItemField(
    int index,
    EditLineItem Function(EditLineItem) update,
  ) {
    final items = List<EditLineItem>.from(state.lineItems);
    items[index] = update(items[index]);
    state = state.copyWith(lineItems: items);
  }

  // ---------------------------------------------------------------------------
  // saveDetails – used by the ship-flow (keeps old structure)
  // ---------------------------------------------------------------------------
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
      ref.invalidate(ordersProvider(tabIndex));
      state = state.copyWith(isSaving: false, isEditMode: false, step: 1);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // editOrder – used by EditOrderScreen, reads from mutable state fields
  // ---------------------------------------------------------------------------
  Future<bool> editOrder() async {
    print('start');
    final s = state;
    final order = s.order;

    final firstItem = s.lineItems.isNotEmpty ? s.lineItems.first : null;
    final totalValue = s.lineItems.fold<double>(
      0,
      (sum, item) =>
          sum +
          (double.tryParse(item.productPrice) ?? 0) *
              (int.tryParse(item.productQuantity) ?? 0),
    );

    final payload = {
      "product_name": firstItem?.productName ?? order.productName,
      "product_price": totalValue,
      "cod_amount": num.tryParse(s.codAmount) ?? order.codAmount,
      "product_quantity": 1, // We use totalValue as the price for 1 unit
      "product_category": firstItem?.productCategory.isNotEmpty == true
          ? firstItem!.productCategory
          : (order.lineItems.isNotEmpty
                ? order.lineItems.first.productCategory
                : "General"),
      "product_sku_no": firstItem?.sku ?? order.productSkuNo ?? "",
      "payment_mode": s.paymentMode,
      "client_orderId": s.clientOrderId,
      "channel_order_id": order.channelOrderId ?? "",
      "channel_store": order.channelStore ?? "",
      "service_type": s.serviceType,
      "lineItems": s.lineItems.map((item) => item.toPayload()).toList(),
      "customer_name": s.customerName,
      "customer_mobile_no": s.customerMobile,
      "customer_email": "support@sharkship.in",
      "customer_address_lane1": s.addressLane1,
      "customer_address_lane2": s.addressLane2,
      "customer_address_landmark": s.landmark,
      "customer_address_pin": int.tryParse(s.pin) ?? 0,
      "customer_address_city": s.city,
      "customer_address_state": s.state,
      "shipment_weight": s.weight, // string per requirement
      "shipment_length": int.tryParse(s.length) ?? 0,
      "shipment_widht": int.tryParse(s.width) ?? 0, // API typo retained
      "shipment_height": int.tryParse(s.height) ?? 0,
    };

    state = state.copyWith(isSaving: true, error: null);

    try {
      print('begin');
      final tabIndex = ref.read(ordersTabProvider);
      final response = await ref
          .read(editOrderUseCaseProvider)
          .execute(order.id, payload);
      print('reached here');
      print(
        '-----------------------------------------------------------------------------------------------------------------------------r-----------',
      );
      // The API returns "messsage" (three s) on success
      if (response['messsage'] == "Order Updated Successfully") {
        print('message');
        ref.invalidate(ordersProvider(tabIndex));
        state = state.copyWith(isSaving: false, isEditMode: false, step: 1);
        return true;
      } else {
        state = state.copyWith(
          isSaving: false,
          error: response['message'] ?? response['error'] ?? "Update failed",
        );
        print('--------------------------------------');
        print(response);
        print(response['message']);
        return false;
      }
    } on DioException catch (e) {
      print('*** DioException in editOrder ***');
      final serverMessage = e.response?.data?['message']?.toString();
      final errorMsg = serverMessage ?? e.message ?? e.toString();
      print('Error: $errorMsg');
      state = state.copyWith(isSaving: false, error: errorMsg);
      return false;
    } catch (e) {
      print('*** Unknown Error in editOrder ***');
      print(e);
      state = state.copyWith(isSaving: false, error: e.toString());
      return false;
    }
  }
}
