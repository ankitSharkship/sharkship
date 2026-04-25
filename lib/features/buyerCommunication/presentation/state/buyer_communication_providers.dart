import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/features/buyerCommunication/domain/usecases/toggle_whatsapp_sms_usecase.dart';

import '../../data/datasources/buyer_communication_datasource.dart';
import '../../data/repositories/buyer_communication_repository_impl.dart';
import '../../domain/repositories/buyer_communication_repository.dart';
import '../../domain/usecases/get_sms_charge_usecase.dart';
import '../../domain/usecases/get_whatsapp_config_usecase.dart';
import '../../domain/usecases/update_whatsapp_sms_config_usecase.dart';
import '../../domain/usecases/send_whatsapp_demo_usecase.dart';

part 'buyer_communication_providers.g.dart';

@riverpod
BuyerCommunicationDataSource buyerCommunicationDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return BuyerCommunicationDataSource(dio);
}

@riverpod
BuyerCommunicationRepository buyerCommunicationRepository(Ref ref) {
  final dataSource = ref.watch(buyerCommunicationDataSourceProvider);
  return BuyerCommunicationRepositoryImpl(dataSource);
}

@riverpod
GetSmsChargeUseCase getSmsChargeUseCase(Ref ref) {
  final repository = ref.watch(buyerCommunicationRepositoryProvider);
  return GetSmsChargeUseCase(repository);
}

@riverpod
GetWhatsappConfigUseCase getWhatsappConfigUseCase(Ref ref) {
  final repository = ref.watch(buyerCommunicationRepositoryProvider);
  return GetWhatsappConfigUseCase(repository);
}

@riverpod
UpdateWhatsappSmsConfigUseCase updateWhatsappSmsConfigUseCase(Ref ref) {
  final repository = ref.watch(buyerCommunicationRepositoryProvider);
  return UpdateWhatsappSmsConfigUseCase(repository);
}

@riverpod
ToggleWhatsappSmsUsecase toggleWhatsappSmsUsecase(Ref ref) {
  final repository = ref.watch(buyerCommunicationRepositoryProvider);
  return ToggleWhatsappSmsUsecase(repository);
}

@riverpod
SendWhatsappDemoUseCase sendWhatsappDemoUseCase(Ref ref) {
  final repository = ref.watch(buyerCommunicationRepositoryProvider);
  return SendWhatsappDemoUseCase(repository);
}

