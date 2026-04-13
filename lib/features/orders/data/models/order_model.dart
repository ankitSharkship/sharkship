import '../../domain/entities/order_entity.dart';
import 'order_address_model.dart';
import 'line_item_model.dart';
import 'customer_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    super.externalId,
    required super.channel,
    super.channelOrderId,
    super.channelStore,
    super.remark,
    required super.createdAt,
    required super.serviceType,
    super.clientOrderId,
    super.carrier,
    required super.codAmount,
    required super.productWeightInKg,
    required super.productName,
    required super.productPrice,
    required super.productQuantity,
    super.productSkuNo,
    super.shippingCharge,
    required super.shipmentLengthInCms,
    required super.shipmentWidthInCms,
    required super.shipmentHeightInCms,
    required super.status,
    super.trackingId,
    super.courierType,
    super.transactionId,
    required super.paymentMode,
    super.lastEventAt,
    super.deliveryDate,
    super.awbGenerateAt,
    required super.isLabelDownloaded,
    super.ivrRemark,
    super.whatsappRemark,
    required OrderAddressModel super.deliveryAddress,
    required List<LineItemModel> super.lineItems,
    required OrderAddressModel super.pickupAddress,
    required CustomerModel super.customer,
    required super.businessName,
    super.pickupDate,
    super.ofd,
    super.errorMessage,
    super.expectedDeliveryDateMax,
    super.expectedDeliveryDateMin,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      externalId: json['external_id']?.toString(),
      channel: json['channel']?.toString() ?? '',
      channelOrderId: json['channel_order_id']?.toString(),
      channelStore: json['channel_store']?.toString(),
      remark: json['remark']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      serviceType: json['service_type']?.toString() ?? '',
      clientOrderId: json['client_orderId']?.toString(),
      carrier: json['carrier']?.toString(),
      codAmount: json['cod_amount'] is num ? json['cod_amount'] as num : 0,
      productWeightInKg: json['product_weight_in_kg']?.toString() ?? '0.00',
      productName: json['product_name']?.toString() ?? '',
      productPrice: json['product_price'] is num
          ? json['product_price'] as num
          : 0,
      productQuantity: json['product_quantity'] ?? 0,
      productSkuNo: json['product_sku_no']?.toString(),
      shippingCharge: json['shipping_charge'] is String
          ? num.parse(json['shipping_charge'])
          : 0,
      shipmentLengthInCms: json['shipment_length_in_cms'] ?? 0,
      shipmentWidthInCms: json['shipment_width_in_cms'] ?? 0,
      shipmentHeightInCms: json['shipment_height_in_cms'] ?? 0,
      status: json['status']?.toString() ?? '',
      trackingId: json['tracking_id']?.toString(),
      courierType: json['courier_type']?.toString(),
      transactionId: json['transaction_id']?.toString(),
      paymentMode: json['payment_mode']?.toString() ?? '',
      lastEventAt: json['last_event_at'] != null
          ? DateTime.parse(json['last_event_at'])
          : null,
      deliveryDate: json['delivery_date'] != null
          ? DateTime.parse(json['delivery_date'])
          : null,
      awbGenerateAt: json['awb_generate_at'] != null
          ? DateTime.parse(json['awb_generate_at'])
          : null,
      isLabelDownloaded: json['isLabelDownloaded'] ?? false,
      ivrRemark: json['ivr_remark']?.toString(),
      whatsappRemark: json['whatsapp_remark']?.toString(),
      deliveryAddress: OrderAddressModel.fromJson(
        json['delivery_address'] ?? {},
      ),
      lineItems: (json['lineItems'] as List? ?? [])
          .map((i) => LineItemModel.fromJson(i))
          .toList(),
      pickupAddress: OrderAddressModel.fromJson(json['pickup_address'] ?? {}),
      customer: CustomerModel.fromJson(json['customer'] ?? {}),
      businessName: json['business_name']?.toString() ?? '',
      pickupDate: json['pickup_date'] != null
          ? DateTime.parse(json['pickup_date'])
          : null,
      expectedDeliveryDateMax: json['expected_delivery_date_max'] != null
          ? DateTime.parse(json['expected_delivery_date_max'])
          : null,
      expectedDeliveryDateMin: json['expected_delivery_date_min'] != null
          ? DateTime.parse(json['expected_delivery_date_min'])
          : null,
      ofd: json['ofd']?.toString(),
      errorMessage: json['errorMessage']?.toString(),
    );
  }
}
