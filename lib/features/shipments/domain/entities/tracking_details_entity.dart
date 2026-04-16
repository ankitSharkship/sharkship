import 'tracking_event_entity.dart';

class TrackingDetailsEntity {
  final String trackingId;
  final String? carrierName;
  final int? sharkshipOrderId;
  final String? sharkshipStatus;
  final String? courierStatus;
  final DateTime? lastEventAt;
  final String? rawStatus;
  final DateTime? pickupDate;
  final DateTime? deliveryDate;
  final DateTime? expectedDeliveryDate;
  final String? shipmentWeight;
  final String? shipmentDimension;
  final String? customerName;
  final String? customerAddress;
  final String? sellerName;
  final String? sellerAddress;
  final List<TrackingEventEntity> trackingInfo;

  const TrackingDetailsEntity({
    required this.trackingId,
    this.carrierName,
    this.sharkshipOrderId,
    this.sharkshipStatus,
    this.courierStatus,
    this.lastEventAt,
    this.rawStatus,
    this.pickupDate,
    this.deliveryDate,
    this.expectedDeliveryDate,
    this.shipmentWeight,
    this.shipmentDimension,
    this.customerName,
    this.customerAddress,
    this.sellerName,
    this.sellerAddress,
    required this.trackingInfo,
  });
}
