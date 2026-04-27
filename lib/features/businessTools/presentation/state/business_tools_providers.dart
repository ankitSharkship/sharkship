import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/features/businessTools/data/datasources/business_tools_remote_datasource.dart';
import 'package:sharkship/features/businessTools/data/repositories/business_tools_repository_impl.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';
import 'package:sharkship/features/businessTools/domain/usecases/add_pickup_address_usecase.dart';
import 'package:sharkship/features/businessTools/domain/usecases/update_pickup_address_usecase.dart';
import 'package:sharkship/features/businessTools/domain/usecases/delete_pickup_address_usecase.dart';
import 'package:sharkship/features/businessTools/domain/usecases/get_pin_details_usecase.dart';
import 'package:sharkship/features/businessTools/domain/usecases/get_retail_api_details_usecase.dart';
import 'package:sharkship/features/businessTools/domain/usecases/request_mis_report_usecase.dart';

part 'business_tools_providers.g.dart';

@riverpod
BusinessToolsRemoteDataSource businessToolsRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return BusinessToolsRemoteDataSource(dio);
}

@riverpod
BusinessToolsRepository businessToolsRepository(Ref ref) {
  final remoteDataSource = ref.watch(businessToolsRemoteDataSourceProvider);
  return BusinessToolsRepositoryImpl(remoteDataSource);
}

@riverpod
AddPickupAddressUseCase addPickupAddressUseCase(Ref ref) {
  final repository = ref.watch(businessToolsRepositoryProvider);
  return AddPickupAddressUseCase(repository);
}

@riverpod
UpdatePickupAddressUseCase updatePickupAddressUseCase(Ref ref) {
  final repository = ref.watch(businessToolsRepositoryProvider);
  return UpdatePickupAddressUseCase(repository);
}

@riverpod
DeletePickupAddressUseCase deletePickupAddressUseCase(Ref ref) {
  final repository = ref.watch(businessToolsRepositoryProvider);
  return DeletePickupAddressUseCase(repository);
}

@riverpod
GetPinDetailsUseCase getPinDetailsUseCase(Ref ref) {
  final repository = ref.watch(businessToolsRepositoryProvider);
  return GetPinDetailsUseCase(repository);
}

@riverpod
GetRetailApiDetailsUseCase getRetailApiDetailsUseCase(Ref ref) {
  final repository = ref.watch(businessToolsRepositoryProvider);
  return GetRetailApiDetailsUseCase(repository);
}

@riverpod
RequestMisReportUseCase requestMisReportUseCase(Ref ref) {
  final repository = ref.watch(businessToolsRepositoryProvider);
  return RequestMisReportUseCase(repository);
}
