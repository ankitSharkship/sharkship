import 'package:sharkship/features/orders/domain/entities/order_entity.dart';
import 'weight_dispute_entity.dart';

class WeightDiscrepancyEntity extends OrderEntity {
  final bool isProofUploaded;
  final String userId;
  final WeightDisputeEntity? weightDispute;
  final String provider;

  WeightDiscrepancyEntity({
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
    required this.isProofUploaded,
    required this.userId,
    this.weightDispute,
    required this.provider,
  });
}
