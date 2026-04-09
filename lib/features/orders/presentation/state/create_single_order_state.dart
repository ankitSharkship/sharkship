import '../../domain/entities/order_address_entity.dart';
import '../../domain/entities/courier_rate_entity.dart';

class CreateSingleOrderState {
  final CustomerDetails? customerDetails;
  final OrderDetails? orderDetails;
  final ShipmentDetails? shipmentDetails;
  final CourierDetails? courierDetails;
  final List<OrderAddressEntity> availablePickupAddresses;
  final bool isLoading;
  final int step;

  CreateSingleOrderState({
    this.customerDetails,
    this.orderDetails,
    this.shipmentDetails,
    this.courierDetails,
    this.availablePickupAddresses = const [],
    this.isLoading = false,
    this.step = 0,
  });

  CreateSingleOrderState copyWith({
    int? step,
    CustomerDetails? customerDetails,
    OrderDetails? orderDetails,
    ShipmentDetails? shipmentDetails,
    CourierDetails? courierDetails,
    List<OrderAddressEntity>? availablePickupAddresses,
    bool? isLoading,
  }) {
    return CreateSingleOrderState(
      step: step ?? this.step,
      customerDetails: customerDetails ?? this.customerDetails,
      orderDetails: orderDetails ?? this.orderDetails,
      shipmentDetails: shipmentDetails ?? this.shipmentDetails,
      courierDetails: courierDetails ?? this.courierDetails,
      availablePickupAddresses:
          availablePickupAddresses ?? this.availablePickupAddresses,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CustomerDetails {
  final String customerName;
  final String customerMobileNumber;
  final String customerEmail;
  final String addressLine1;
  final String? addressLine2;
  final String pin;
  final String city;
  final String state;
  CustomerDetails({
    required this.customerName,
    required this.customerMobileNumber,
    required this.customerEmail,
    required this.addressLine1,
    this.addressLine2,
    required this.pin,
    required this.city,
    required this.state,
  });
}

class OrderDetails {
  final List<ProductDetails> productsList;
  final PaymentMode paymentMode;
  final ServiceType serviceType;
  final OrderAddressEntity? selectedPickupAddress;
  OrderDetails({
    required this.productsList,
    required this.paymentMode,
    required this.serviceType,
    this.selectedPickupAddress,
  });
}

class ProductDetails {
  final String productName;
  final String productPrice;
  final int productQuantity;
  final String? skuNo;
  final CategoryType category;

  ProductDetails({
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    this.skuNo,
    required this.category,
  });
}

class ShipmentDetails {
  final String? clientId;
  final String length;
  final String width;
  final String height;
  final String actualWeight;
  final String? volumetricWeight;
  final String? pickupPin; // Added because the screen shows pickup PIN

  ShipmentDetails({
    this.clientId,
    required this.length,
    required this.width,
    required this.height,
    required this.actualWeight,
    this.volumetricWeight,
    this.pickupPin,
  });
}

class CourierDetails {
  final List<CourierRateEntity> availableRates;
  final CourierRateEntity? selectedRate;

  CourierDetails({
    this.availableRates = const [],
    this.selectedRate,
  });
}

enum CategoryType {
  apparelsAndAccessories('Apparels and Accessories'),
  homeDecor('Home Decor'),
  personalCare('Personal Care'),
  fashion('Fashion'),
  electronics('Electronics'),
  bags('Bags'),
  fitnessGymEquipmentsAndAccessories('Fitness, Gym Equipments and Accessories'),
  healthFitnessAndHygiene('Health, Fitness and Hygiene'),
  jewellery('Jewellery');

  const CategoryType(this.label);
  final String label;
}

enum PaymentMode {
  cod('COD'),
  prepaid('PREPAID');

  const PaymentMode(this.label);
  final String label;
}

enum ServiceType {
  panIndia('PAN_INDIA'),
  sdd('SDD'),
  ndd('NDD');

  const ServiceType(this.label);
  final String label;
}
