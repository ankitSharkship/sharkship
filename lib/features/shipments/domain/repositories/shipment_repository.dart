import '../entities/tracking_details_entity.dart';

abstract class ShipmentRepository {
  Future<TrackingDetailsEntity> getTrackingDetails(String trackingId);
}
