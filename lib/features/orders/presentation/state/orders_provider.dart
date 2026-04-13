import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/orders/domain/usecases/bulk_upload_usecase.dart';
import 'package:sharkship/features/orders/domain/usecases/delete_orders_usecase.dart';
import 'package:sharkship/features/orders/domain/usecases/download_template_usecase.dart';
import 'package:sharkship/features/orders/domain/usecases/ship_order_usecase.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/datasources/orders_datasource.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../data/repositories/orders_repository_impl.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import '../../domain/usecases/get_pickup_addresses_usecase.dart';
import '../../domain/usecases/get_shipping_rates_usecase.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/get_courier_priority_usecase.dart';
import '../../domain/usecases/get_courier_partners_usecase.dart';
import '../../domain/usecases/update_courier_priority_usecase.dart';
import '../../domain/usecases/set_default_pickup_address_usecase.dart';
import '../../domain/usecases/export_orders_usecase.dart';
import '../../domain/usecases/edit_order_usecase.dart';
import '../../domain/usecases/download_shipping_label_usecase.dart';
import '../../domain/usecases/download_order_invoice_usecase.dart';
import '../../domain/usecases/generate_manifestation_usecase.dart';
import '../../domain/usecases/cancel_orders_usecase.dart';
import '../../domain/usecases/clone_order_usecase.dart';

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

@riverpod
ShipOrdersUsecase shipOrdersUsecase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return ShipOrdersUsecase(repository);
}

@riverpod
GetCourierPriorityUseCase getCourierPriorityUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return GetCourierPriorityUseCase(repository);
}

@riverpod
GetCourierPartnersUseCase getCourierPartnersUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return GetCourierPartnersUseCase(repository);
}

@riverpod
UpdateCourierPriorityUseCase updateCourierPriorityUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return UpdateCourierPriorityUseCase(repository);
}

@riverpod
SetDefaultPickupAddressUseCase setDefaultPickupAddressUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return SetDefaultPickupAddressUseCase(repository);
}

@riverpod
ExportOrdersUseCase exportOrdersUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return ExportOrdersUseCase(repository);
}

@riverpod
EditOrderUseCase editOrderUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return EditOrderUseCase(repository);
}

@riverpod
DownloadShippingLabelUseCase downloadShippingLabelUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return DownloadShippingLabelUseCase(repository);
}

@riverpod
DownloadOrderInvoiceUseCase downloadOrderInvoiceUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return DownloadOrderInvoiceUseCase(repository);
}

@riverpod
GenerateManifestationUseCase generateManifestationUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return GenerateManifestationUseCase(repository);
}

@riverpod
CancelOrdersUseCase cancelOrdersUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return CancelOrdersUseCase(repository);
}

@riverpod
CloneOrderUseCase cloneOrderUseCase(Ref ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return CloneOrderUseCase(repository);
}
