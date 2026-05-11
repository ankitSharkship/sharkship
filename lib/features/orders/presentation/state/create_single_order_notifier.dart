import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/orders/presentation/state/create_single_order_state.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import 'package:sharkship/features/orders/domain/entities/courier_rate_entity.dart';
import 'package:sharkship/features/orders/domain/entities/order_address_entity.dart';

part 'create_single_order_notifier.g.dart';

@riverpod
class CreateSingleOrderNotifier extends _$CreateSingleOrderNotifier {
  @override
  CreateSingleOrderState build() {
    return CreateSingleOrderState();
  }

  void updateCustomerDetails(CustomerDetails details) {
    state = state.copyWith(customerDetails: details);
  }

  void updateOrderDetails(OrderDetails details) {
    state = state.copyWith(orderDetails: details);
  }

  void updateShipmentDetails(ShipmentDetails details) {
    state = state.copyWith(shipmentDetails: details);
  }

  void selectPickupAddress(OrderAddressEntity address) {
    final currentOrderDetails =
        state.orderDetails ??
        OrderDetails(
          productsList: [],
          paymentMode: PaymentMode.prepaid,
          serviceType: ServiceType.panIndia,
        );
    state = state.copyWith(
      orderDetails: OrderDetails(
        productsList: currentOrderDetails.productsList,
        paymentMode: currentOrderDetails.paymentMode,
        serviceType: currentOrderDetails.serviceType,
        selectedPickupAddress: address,
      ),
    );
  }

  Future<bool> nextStep() async {
    final currentStep = state.step;

    if (currentStep == 0) {
      // Transition from Customer to Order Details
      // We should fetch pickup addresses here if not already fetched
      if (state.availablePickupAddresses.isEmpty) {
        await fetchPickupAddresses();
      }
      state = state.copyWith(step: 1);
      return true;
    } else if (currentStep == 1) {
      // Transition from Order to Shipment
      state = state.copyWith(step: 2);
      return true;
    } else if (currentStep == 2) {
      // Transition from Shipment to Courier
      // Fetch shipping rates here!

      final success = await fetchShippingRates();
      if (success) {
        state = state.copyWith(step: 3);
      }
      return success;
    } else if (currentStep == 3) {
      // Final submission logic would go here
      return true;
    }
    return false;
  }

  void prevStep() {
    if (state.step > 0) {
      state = state.copyWith(step: state.step - 1);
    }
  }

  Future<void> fetchPickupAddresses() async {
    state = state.copyWith(isLoading: true);
    try {
      final addresses = await ref
          .read(getPickupAddressesUseCaseProvider)
          .execute();
      state = state.copyWith(
        availablePickupAddresses: addresses,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // In a real app we'd show a Snackbar or something
    }
  }

  Future<bool> fetchShippingRates() async {
    if (state.customerDetails == null ||
        state.orderDetails == null ||
        state.shipmentDetails == null) {
      return false;
    }

    state = state.copyWith(isLoading: true);
    try {
      final orderDetails = state.orderDetails!;
      final shipment = state.shipmentDetails!;

      // Calculate total product value
      double productValue = 0;
      for (var p in orderDetails.productsList) {
        productValue +=
            (double.tryParse(p.productPrice) ?? 0) * p.productQuantity;
      }

      final params = ShippingRateParams(
        source:
            orderDetails.selectedPickupAddress?.pin?.toString() ??
            shipment.pickupPin ??
            "",
        destination: state.customerDetails!.pin,
        paymentType: orderDetails.paymentMode == PaymentMode.cod
            ? "COD"
            : "PREPAID",
        weight: num.tryParse(shipment.actualWeight) ?? 0,
        productValue: productValue,
        length: shipment.length,
        width: shipment.width,
        height: shipment.height,
        serviceType: orderDetails.serviceType.label,
      );

      final response = await ref
          .read(getShippingRatesUseCaseProvider)
          .execute(params);

      state = state.copyWith(
        courierDetails: CourierDetails(availableRates: response.rates),
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  void selectRate(CourierRateEntity rate) {
    state = state.copyWith(
      courierDetails: CourierDetails(
        availableRates: state.courierDetails?.availableRates ?? [],
        selectedRate: rate,
      ),
    );
  }

  Future<bool> submitOrder() async {
    if (state.customerDetails == null ||
        state.orderDetails == null ||
        state.shipmentDetails == null ||
        state.courierDetails?.selectedRate == null) {
      return false;
    }

    state = state.copyWith(isLoading: true);
    try {
      final customer = state.customerDetails!;
      final order = state.orderDetails!;
      final shipment = state.shipmentDetails!;
      final selectedRate = state.courierDetails!.selectedRate!;

      final lineItems = order.productsList
          .map(
            (p) => LineItemParams(
              productName: p.productName,
              productPrice: num.tryParse(p.productPrice) ?? 0,
              productQuantity: p.productQuantity,
              productCategory: p.category.label,
            ),
          )
          .toList();

      double totalValue = 0;
      for (var item in lineItems) {
        totalValue += (item.productPrice * item.productQuantity);
      }

      final params = CreateOrderParams(
        customer: OrderCustomerParams(
          name: customer.customerName,
          mobileNo: customer.customerMobileNumber,
          email: customer.customerEmail,
          address: OrderAddressParams(
            addressLane1: customer.addressLine1,
            addressLane2: customer.addressLine2 ?? "",
            pin: customer.pin,
            landmark: "",
            city: customer.city,
            state: customer.state,
          ),
        ),
        order: OrderDataParams(
          productName: order.productsList[0].productName,
          productPrice: totalValue,
          codAmount: order.paymentMode == PaymentMode.cod ? totalValue : 0,
          productQuantity: 1,
          productCategory: order.productsList[0].category.label,
          paymentMode: order.paymentMode == PaymentMode.cod ? "COD" : "PREPAID",
          serviceType: order.serviceType.label,
          lineItems: lineItems,
        ),
        pickupDetails: PickupDetailsParams(
          addressId: order.selectedPickupAddress?.id?.toString() ?? "",
        ),
        shipmentDetails: ShipmentDetailsParams(
          weight: num.tryParse(shipment.actualWeight) ?? 0,
          volumetricWeight: VolumetricWeightParams(
            length: num.tryParse(shipment.length) ?? 0,
            width: num.tryParse(shipment.width) ?? 0,
            height: num.tryParse(shipment.height) ?? 0,
          ),
          carrier: CarrierParams(
            carrierId: selectedRate.carrierId,
            courierType: selectedRate.courierType,
            baseWeight: selectedRate.baseWeight,
          ),
        ),
      );

      final success = await ref
          .read(createOrderUseCaseProvider)
          .execute(params);
      Posthog().capture(
        eventName: 'single_order_creation',
        properties: {"status": success},
      );
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}
