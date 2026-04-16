import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/datasources/shipment_datasource.dart';
import '../../data/repositories/shipment_repository_impl.dart';
import '../../domain/repositories/shipment_repository.dart';
import '../../domain/usecases/get_tracking_details_usecase.dart';

part 'tracking_providers.g.dart';

@riverpod
ShipmentDataSource shipmentDataSource(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ShipmentDataSource(dioClient.dio);
}

@riverpod
ShipmentRepository shipmentRepository(Ref ref) {
  final dataSource = ref.watch(shipmentDataSourceProvider);
  return ShipmentRepositoryImpl(dataSource);
}

@riverpod
GetTrackingDetailsUseCase getTrackingDetailsUseCase(Ref ref) {
  final repository = ref.watch(shipmentRepositoryProvider);
  return GetTrackingDetailsUseCase(repository);
}
