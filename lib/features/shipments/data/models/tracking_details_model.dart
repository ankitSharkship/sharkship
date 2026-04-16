import '../../domain/entities/tracking_details_entity.dart';
import 'tracking_event_model.dart';

class TrackingDetailsModel extends TrackingDetailsEntity {
  const TrackingDetailsModel({
    required super.trackingId,
    super.carrierName,
    super.sharkshipOrderId,
    super.sharkshipStatus,
    super.courierStatus,
    super.lastEventAt,
    super.rawStatus,
    super.pickupDate,
    super.deliveryDate,
    super.expectedDeliveryDate,
    super.shipmentWeight,
    super.shipmentDimension,
    super.customerName,
    super.customerAddress,
    super.sellerName,
    super.sellerAddress,
    required List<TrackingEventModel> super.trackingInfo,
  });

  factory TrackingDetailsModel.fromJson(Map<String, dynamic> json) {
    return TrackingDetailsModel(
      trackingId: json['tracking_id'] as String,
      carrierName: json['carrier_name'] as String?,
      sharkshipOrderId: json['sharkship_order_id'] as int?,
      sharkshipStatus: json['sharkship_status'] as String?,
      courierStatus: json['courier_status'] as String?,
      lastEventAt: json['last_event_at'] != null
          ? DateTime.tryParse(json['last_event_at'] as String)
          : null,
      rawStatus: json['raw_status'] as String?,
      pickupDate: json['pickup_date'] != null
          ? DateTime.tryParse(json['pickup_date'] as String)
          : null,
      deliveryDate: json['delivery_date'] != null
          ? DateTime.tryParse(json['delivery_date'] as String)
          : null,
      expectedDeliveryDate: json['expected_delivery_date'] != null
          ? DateTime.tryParse(json['expected_delivery_date'] as String)
          : null,
      shipmentWeight: json['shipment_weight']?.toString(),
      shipmentDimension: json['shipment_dimension'] as String?,
      customerName: json['customer_name'] as String?,
      customerAddress: json['customer_address'] as String?,
      sellerName: json['seller_name'] as String?,
      sellerAddress: json['seller_address'] as String?,
      trackingInfo:
          (json['tracking_info'] as List<dynamic>?)
              ?.map(
                (e) => TrackingEventModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tracking_id': trackingId,
      'carrier_name': carrierName,
      'sharkship_order_id': sharkshipOrderId,
      'sharkship_status': sharkshipStatus,
      'courier_status': courierStatus,
      'last_event_at': lastEventAt?.toIso8601String(),
      'raw_status': rawStatus,
      'pickup_date': pickupDate?.toIso8601String(),
      'delivery_date': deliveryDate?.toIso8601String(),
      'expected_delivery_date': expectedDeliveryDate?.toIso8601String(),
      'shipment_weight': shipmentWeight,
      'shipment_dimension': shipmentDimension,
      'customer_name': customerName,
      'customer_address': customerAddress,
      'seller_name': sellerName,
      'seller_address': sellerAddress,
      'tracking_info': (trackingInfo as List<TrackingEventModel>)
          .map((e) => e.toJson())
          .toList(),
    };
  }
}
