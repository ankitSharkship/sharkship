import 'package:sharkship/features/orders/data/models/customer_model.dart';
import 'package:sharkship/features/orders/data/models/line_item_model.dart';
import 'package:sharkship/features/orders/data/models/order_address_model.dart';
import '../../domain/entities/weight_discrepancy_entity.dart';
import 'weight_dispute_model.dart';

class WdModel extends WeightDiscrepancyEntity {
  WdModel({
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
    required super.deliveryAddress,
    required super.lineItems,
    required super.pickupAddress,
    required super.customer,
    required super.businessName,
    super.pickupDate,
    super.expectedDeliveryDateMin,
    super.expectedDeliveryDateMax,
    super.ofd,
    super.errorMessage,
    required super.isProofUploaded,
    required super.userId,
    super.weightDispute,
    required super.provider,
  });

  factory WdModel.fromJson(Map<String, dynamic> json) {
    return WdModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      codAmount: json['cod_amount'] ?? 0,
      serviceType: json['service_type'] ?? '',
      carrier: json['carrier'] ?? '',
      productWeightInKg: json['product_weight_in_kg']?.toString() ?? '0',
      productName: json['product_name'] ?? '',
      productPrice: json['product_price'] ?? 0,
      productQuantity: json['product_quantity'] ?? 0,
      productSkuNo: json['product_sku_no'],
      shippingCharge: json['shipping_charge'] != null 
          ? num.tryParse(json['shipping_charge'].toString()) 
          : null,
      shipmentLengthInCms: json['shipment_length_in_cms']?.toInt() ?? 0,
      shipmentWidthInCms: json['shipment_width_in_cms']?.toInt() ?? 0,
      shipmentHeightInCms: json['shipment_height_in_cms']?.toInt() ?? 0,
      status: json['status'] ?? '',
      trackingId: json['tracking_id']?.toString(),
      courierType: json['courier_type'] ?? '',
      transactionId: json['transaction_id'],
      paymentMode: json['payment_mode'] ?? 'PREPAID',
      channel: json['channel'] ?? '',
      isProofUploaded: json['is_proof_uploaded'] ?? false,
      deliveryDate: json['delivery_date'] != null 
          ? DateTime.parse(json['delivery_date']) 
          : null,
      deliveryAddress: OrderAddressModel.fromJson(json['delivery_address']),
      pickupAddress: OrderAddressModel.fromJson(json['pickup_address']),
      userId: json['userId']?.toString() ?? '',
      businessName: json['business_name'] ?? '',
      weightDispute: json['weight_dispute'] != null
          ? WeightDisputeModel.fromJson(json['weight_dispute'])
          : null,
      customer: CustomerModel.fromJson(json['customer']),
      lineItems: (json['lineItems'] as List)
          .map((i) => LineItemModel.fromJson(i))
          .toList(),
      channelOrderId: json['channel_order_id']?.toString() ?? '',
      channelStore: json['channel_store'],
      clientOrderId: json['client_orderId'],
      provider: json['provider'] ?? 'SHARKSHIP',
      isLabelDownloaded: false,
    );
  }
}
