import 'dart:io';

import '../entities/orders_response_entity.dart';
import '../entities/order_address_entity.dart';
import '../entities/courier_rate_entity.dart';
import '../entities/courier_priority_entity.dart';
import '../entities/courier_partner_entity.dart';

class OrderListParams {
  final int? skip;
  final int? total;
  final DateTime startDate;
  final DateTime endDate;
  final String? channel;
  final String? paymentType;
  final String? carrier;
  final String? status;
  final List<String>? channelStore;
  final String? isNdr;
  final String? isRto;
  final String? isLabelDownloaded;
  final String? isFailed;
  final num? weight;
  final String? productName;
  final List<String>? serviceType;
  final String? remark;
  final int? pickupAddressId;
  final String? shopifyOrderIdFilter;
  final String? whatsappRemark;

  OrderListParams({
    this.skip,
    this.total,
    required this.startDate,
    required this.endDate,
    this.channel,
    this.paymentType,
    this.carrier,
    this.status,
    this.channelStore,
    this.isNdr,
    this.isRto,
    this.isLabelDownloaded,
    this.isFailed,
    this.weight,
    this.productName,
    this.serviceType,
    this.remark,
    this.pickupAddressId,
    this.shopifyOrderIdFilter,
    this.whatsappRemark,
  });

  Map<String, dynamic> toJson() {
    return {
      if (skip != null) 'skip': skip,
      if (total != null) 'total': total,
      'startDate': startDate,
      'endDate': endDate,
      if (channel != null) 'channel': channel,
      if (paymentType != null) 'payment_type': paymentType,
      if (carrier != null) 'carrier': carrier,
      if (status != null) 'status': status,
      if (channelStore != null) 'channel_store': channelStore,
      if (isNdr != null) 'isNdr': isNdr,
      if (isRto != null) 'isRto': isRto,
      if (isLabelDownloaded != null) 'isLabelDownloaded': isLabelDownloaded,
      if (isFailed != null) 'isFailed': isFailed,
      if (weight != null) 'weight': weight,
      if (productName != null) 'product_name': productName,
      if (serviceType != null) 'service_type': serviceType,
      if (remark != null) 'remark': remark,
      if (pickupAddressId != null) 'pickup_address_id': pickupAddressId,
      if (shopifyOrderIdFilter != null)
        'shopify_order_id_filter': shopifyOrderIdFilter,
      if (whatsappRemark != null) 'whatsapp_remark': whatsappRemark,
    };
  }
}

class ShippingRateParams {
  final String source;
  final String destination;
  final String paymentType;
  final num weight;
  final num productValue;
  final String length;
  final String width;
  final String height;
  final String serviceType;

  ShippingRateParams({
    required this.source,
    required this.destination,
    required this.paymentType,
    required this.weight,
    required this.productValue,
    required this.length,
    required this.width,
    required this.height,
    required this.serviceType,
  });

  Map<String, dynamic> getQueryParameters() {
    return {
      'source': source,
      'destination': destination,
      'payment_type': paymentType,
      'weight': weight.toString(),
      'productValue': productValue.toString(),
    };
  }

  Map<String, String> getHeaders() {
    return {
      'length': length,
      'width': width,
      'height': height,
      'service_type': serviceType,
    };
  }
}

class CreateOrderParams {
  final OrderCustomerParams customer;
  final OrderDataParams order;
  final PickupDetailsParams pickupDetails;
  final ShipmentDetailsParams shipmentDetails;

  CreateOrderParams({
    required this.customer,
    required this.order,
    required this.pickupDetails,
    required this.shipmentDetails,
  });

  Map<String, dynamic> toJson() => {
    "customer": customer.toJson(),
    "order": order.toJson(),
    "pickup_details": pickupDetails.toJson(),
    "shipment_details": shipmentDetails.toJson(),
  };
}

class OrderCustomerParams {
  final String name;
  final String mobileNo;
  final String email;
  final OrderAddressParams address;

  OrderCustomerParams({
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_no": mobileNo,
    "email": email,
    "address": address.toJson(),
  };
}

class OrderAddressParams {
  final String addressLane1;
  final String addressLane2;
  final String pin;
  final String landmark;
  final String city;
  final String state;

  OrderAddressParams({
    required this.addressLane1,
    required this.addressLane2,
    required this.pin,
    required this.landmark,
    required this.city,
    required this.state,
  });

  Map<String, dynamic> toJson() => {
    "address_lane1": addressLane1,
    "address_lane2": addressLane2,
    "Pin": pin,
    "landmark": landmark,
    "city": city,
    "state": state,
    "pin": int.tryParse(pin) ?? 0,
  };
}

class OrderDataParams {
  final String productName;
  final num productPrice;
  final num codAmount;
  final int productQuantity;
  final String taxRate;
  final String? productSkuNo;
  final String? clientOrderId;
  final String productCategory;
  final String paymentMode;
  final String serviceType;
  final List<LineItemParams> lineItems;

  OrderDataParams({
    required this.productName,
    required this.productPrice,
    required this.codAmount,
    required this.productQuantity,
    this.taxRate = "0",
    this.productSkuNo,
    this.clientOrderId,
    required this.productCategory,
    required this.paymentMode,
    required this.serviceType,
    required this.lineItems,
  });

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "product_price": productPrice,
    "cod_amount": codAmount,
    "product_quantity": productQuantity,
    "tax_rate": taxRate,
    "product_sku_no": productSkuNo,
    "client_orderId": clientOrderId,
    "product_category": productCategory,
    "payment_mode": paymentMode,
    "service_type": serviceType,
    "lineItems": lineItems.map((e) => e.toJson()).toList(),
  };
}

class LineItemParams {
  final String productName;
  final num productPrice;
  final int productQuantity;
  final String productCategory;
  final String? productSkuNo;
  final int taxRate;

  LineItemParams({
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.productCategory,
    this.productSkuNo,
    this.taxRate = 0,
  });

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "product_price": productPrice,
    "product_quantity": productQuantity,
    "product_category": productCategory,
    "product_sku_no": productSkuNo,
    "tax_rate": taxRate,
  };
}

class PickupDetailsParams {
  final String addressId;
  PickupDetailsParams({required this.addressId});
  Map<String, dynamic> toJson() => {"address_id": addressId};
}

class ShipmentDetailsParams {
  final num weight;
  final VolumetricWeightParams volumetricWeight;
  final CarrierParams carrier;

  ShipmentDetailsParams({
    required this.weight,
    required this.volumetricWeight,
    required this.carrier,
  });

  Map<String, dynamic> toJson() => {
    "weight": weight,
    "volumetric_weight": volumetricWeight.toJson(),
    "carrier": carrier.toJson(),
  };
}

class VolumetricWeightParams {
  final num length;
  final num width;
  final num height;

  VolumetricWeightParams({
    required this.length,
    required this.width,
    required this.height,
  });

  Map<String, dynamic> toJson() => {
    "length": length,
    "width": width,
    "height": height,
  };
}

class CarrierParams {
  final int carrierId;
  final String courierType;
  final num baseWeight;

  CarrierParams({
    required this.carrierId,
    required this.courierType,
    required this.baseWeight,
  });

  Map<String, dynamic> toJson() => {
    "carrierId": carrierId,
    "courier_type": courierType,
    "base_weight": baseWeight,
  };
}

abstract class OrdersRepository {
  Future<OrdersResponseEntity> getOrders(OrderListParams params);
  Future<List<OrderAddressEntity>> getPickupAddresses();
  Future<bool> setDefaultPickupAddress(int id);
  Future<ShippingRateResponseEntity> getShippingRates(
    ShippingRateParams params,
  );
  Future<bool> createOrder(CreateOrderParams params);
  Future<void> downloadTemplate();
  Future<bool> handleBulkUpload(File file);
  Future<Map<String, dynamic>> deleteOrders(Map<String, dynamic> orderIds);
  Future<CourierPriorityEntity> getCourierPriority();
  Future<bool> updateCourierPriority(Map<String, dynamic> data);
  Future<List<CourierPartnerEntity>> getCourierPartners();
  Future<Map<String, dynamic>> shipOrders(Map<String, dynamic> orderIds);
  Future<void> exportOrders(List<int> orderIds);
  Future<Map<String, dynamic>> editOrder(int id, Map<String, dynamic> data);
  Future<void> downloadShippingLabel(List<int> orderIds);
  Future<void> updateInvoiceConfiguration(Map<String, dynamic> config);
  Future<void> downloadOrderInvoice(List<int> orderIds);
  Future<void> generateManifestation(List<int> orderIds);
  Future<void> cancelOrders(List<int> orderIds);
  Future<void> cloneOrder(int id);
}
