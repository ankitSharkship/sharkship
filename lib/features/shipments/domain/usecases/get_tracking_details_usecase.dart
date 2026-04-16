import '../repositories/shipment_repository.dart';
import '../entities/tracking_details_entity.dart';

class GetTrackingDetailsUseCase {
  final ShipmentRepository repository;

  GetTrackingDetailsUseCase(this.repository);

  Future<TrackingDetailsEntity> execute(String trackingId) async {
    return await repository.getTrackingDetails(trackingId);
  }
}
