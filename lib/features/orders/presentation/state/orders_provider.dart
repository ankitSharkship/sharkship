import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/orders/domain/usecases/bulk_upload_usecase.dart';
import 'package:sharkship/features/orders/domain/usecases/delete_orders_usecase.dart';
import 'package:sharkship/features/orders/domain/usecases/download_template_usecase.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/datasources/orders_datasource.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../data/repositories/orders_repository_impl.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/get_pickup_addresses_usecase.dart';
import '../../domain/usecases/get_shipping_rates_usecase.dart';
import '../../domain/usecases/create_order_usecase.dart';

part 'orders_provider.g.dart';

@riverpod
OrdersDataSource ordersDataSource(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OrdersDataSource(dioClient.dio);
}

@riverpod
OrdersRepository ordersRepository(Ref ref) {
  final dataSource = ref.watch(ordersDataSourceProvider);
  return OrdersRepositoryImpl(dataSource);
}

@riverpod
GetOrdersUseCase getOrdersUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return GetOrdersUseCase(repository);
}

@riverpod
GetPickupAddressesUseCase getPickupAddressesUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return GetPickupAddressesUseCase(repository);
}

@riverpod
GetShippingRatesUseCase getShippingRatesUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return GetShippingRatesUseCase(repository);
}

@riverpod
CreateOrderUseCase createOrderUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return CreateOrderUseCase(repository);
}

@riverpod
DownloadTemplateUsecase downloadTemplateUsecase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return DownloadTemplateUsecase(repository);
}

@riverpod
BulkUploadUsecase bulkUploadUsecase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return BulkUploadUsecase(repository);
}

@riverpod
DeleteOrdersUsecase deleteOrdersUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return DeleteOrdersUsecase(repository);
}
