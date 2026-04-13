import 'line_item_entity.dart';
import 'customer_entity.dart';
import 'order_address_entity.dart';

class OrderEntity {
  final int id;
  final String? externalId;
  final String channel;
  final String? channelOrderId;
  final String? channelStore;
  final String? remark;
  final DateTime createdAt;
  final String serviceType;
  final String? clientOrderId;
  final String? carrier;
  final num codAmount;
  final String productWeightInKg;
  final String productName;
  final num productPrice;
  final int productQuantity;
  final String? productSkuNo;
  final num? shippingCharge;
  final int shipmentLengthInCms;
  final int shipmentWidthInCms;
  final int shipmentHeightInCms;
  final String status;
  final String? trackingId;
  final String? courierType;
  final String? transactionId;
  final String paymentMode;
  final DateTime? lastEventAt;
  final DateTime? deliveryDate;
  final DateTime? awbGenerateAt;
  final bool isLabelDownloaded;
  final String? ivrRemark;
  final String? whatsappRemark;
  final OrderAddressEntity deliveryAddress;
  final List<LineItemEntity> lineItems;
  final OrderAddressEntity pickupAddress;
  final CustomerEntity customer;
  final String businessName;
  final DateTime? pickupDate;
  final String? ofd;
  final String? errorMessage;
  final DateTime? expectedDeliveryDateMin;
  final DateTime? expectedDeliveryDateMax;

  OrderEntity({
    required this.id,
    this.externalId,
    required this.channel,
    this.channelOrderId,
    this.channelStore,
    this.remark,
    required this.createdAt,
    required this.serviceType,
    this.clientOrderId,
    this.carrier,
    required this.codAmount,
    required this.productWeightInKg,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    this.productSkuNo,
    this.shippingCharge,
    required this.shipmentLengthInCms,
    required this.shipmentWidthInCms,
    required this.shipmentHeightInCms,
    required this.status,
    this.trackingId,
    this.courierType,
    this.transactionId,
    required this.paymentMode,
    this.lastEventAt,
    this.deliveryDate,
    this.awbGenerateAt,
    required this.isLabelDownloaded,
    this.ivrRemark,
    this.whatsappRemark,
    required this.deliveryAddress,
    required this.lineItems,
    required this.pickupAddress,
    required this.customer,
    required this.businessName,
    this.pickupDate,
    this.expectedDeliveryDateMin,
    this.expectedDeliveryDateMax,
    this.ofd,
    this.errorMessage,
  });
}
