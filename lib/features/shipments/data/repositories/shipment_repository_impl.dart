import '../../domain/entities/tracking_details_entity.dart';
import '../../domain/repositories/shipment_repository.dart';
import '../datasources/shipment_datasource.dart';

class ShipmentRepositoryImpl implements ShipmentRepository {
  final ShipmentDataSource dataSource;

  ShipmentRepositoryImpl(this.dataSource);

  @override
  Future<TrackingDetailsEntity> getTrackingDetails(String trackingId) async {
    return await dataSource.getTrackingDetails(trackingId);
  }
}
