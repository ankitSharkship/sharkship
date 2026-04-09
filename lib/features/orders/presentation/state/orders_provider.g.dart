// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ordersDataSource)
const ordersDataSourceProvider = OrdersDataSourceProvider._();

final class OrdersDataSourceProvider
    extends
        $FunctionalProvider<
          OrdersDataSource,
          OrdersDataSource,
          OrdersDataSource
        >
    with $Provider<OrdersDataSource> {
  const OrdersDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersDataSourceHash();

  @$internal
  @override
  $ProviderElement<OrdersDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrdersDataSource create(Ref ref) {
    return ordersDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrdersDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrdersDataSource>(value),
    );
  }
}

String _$ordersDataSourceHash() => r'5bf0d89ed313a0f77b0ab0c38a4f3d5c5a3683aa';

@ProviderFor(ordersRepository)
const ordersRepositoryProvider = OrdersRepositoryProvider._();

final class OrdersRepositoryProvider
    extends
        $FunctionalProvider<
          OrdersRepository,
          OrdersRepository,
          OrdersRepository
        >
    with $Provider<OrdersRepository> {
  const OrdersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersRepositoryHash();

  @$internal
  @override
  $ProviderElement<OrdersRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrdersRepository create(Ref ref) {
    return ordersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrdersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrdersRepository>(value),
    );
  }
}

String _$ordersRepositoryHash() => r'e94f374950c231df0ec9e9e4e5d654aae9c6db48';

@ProviderFor(getOrdersUseCase)
const getOrdersUseCaseProvider = GetOrdersUseCaseProvider._();

final class GetOrdersUseCaseProvider
    extends
        $FunctionalProvider<
          GetOrdersUseCase,
          GetOrdersUseCase,
          GetOrdersUseCase
        >
    with $Provider<GetOrdersUseCase> {
  const GetOrdersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getOrdersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getOrdersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetOrdersUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetOrdersUseCase create(Ref ref) {
    return getOrdersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetOrdersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetOrdersUseCase>(value),
    );
  }
}

String _$getOrdersUseCaseHash() => r'025fed6672465ef7dfa35ce5728661baea977781';

@ProviderFor(getPickupAddressesUseCase)
const getPickupAddressesUseCaseProvider = GetPickupAddressesUseCaseProvider._();

final class GetPickupAddressesUseCaseProvider
    extends
        $FunctionalProvider<
          GetPickupAddressesUseCase,
          GetPickupAddressesUseCase,
          GetPickupAddressesUseCase
        >
    with $Provider<GetPickupAddressesUseCase> {
  const GetPickupAddressesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPickupAddressesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPickupAddressesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPickupAddressesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPickupAddressesUseCase create(Ref ref) {
    return getPickupAddressesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPickupAddressesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPickupAddressesUseCase>(value),
    );
  }
}

String _$getPickupAddressesUseCaseHash() =>
    r'01cc053b74524a931d969f1889cf324a1900888e';

@ProviderFor(getShippingRatesUseCase)
const getShippingRatesUseCaseProvider = GetShippingRatesUseCaseProvider._();

final class GetShippingRatesUseCaseProvider
    extends
        $FunctionalProvider<
          GetShippingRatesUseCase,
          GetShippingRatesUseCase,
          GetShippingRatesUseCase
        >
    with $Provider<GetShippingRatesUseCase> {
  const GetShippingRatesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getShippingRatesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getShippingRatesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetShippingRatesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetShippingRatesUseCase create(Ref ref) {
    return getShippingRatesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetShippingRatesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetShippingRatesUseCase>(value),
    );
  }
}

String _$getShippingRatesUseCaseHash() =>
    r'35668ddc17263712b6434773991c242290bc8452';

@ProviderFor(createOrderUseCase)
const createOrderUseCaseProvider = CreateOrderUseCaseProvider._();

final class CreateOrderUseCaseProvider
    extends
        $FunctionalProvider<
          CreateOrderUseCase,
          CreateOrderUseCase,
          CreateOrderUseCase
        >
    with $Provider<CreateOrderUseCase> {
  const CreateOrderUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createOrderUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createOrderUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateOrderUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateOrderUseCase create(Ref ref) {
    return createOrderUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateOrderUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateOrderUseCase>(value),
    );
  }
}

String _$createOrderUseCaseHash() =>
    r'b0b50256a3a612ee980f7ec81e7ffa9825b17e74';

@ProviderFor(downloadTemplateUsecase)
const downloadTemplateUsecaseProvider = DownloadTemplateUsecaseProvider._();

final class DownloadTemplateUsecaseProvider
    extends
        $FunctionalProvider<
          DownloadTemplateUsecase,
          DownloadTemplateUsecase,
          DownloadTemplateUsecase
        >
    with $Provider<DownloadTemplateUsecase> {
  const DownloadTemplateUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadTemplateUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadTemplateUsecaseHash();

  @$internal
  @override
  $ProviderElement<DownloadTemplateUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DownloadTemplateUsecase create(Ref ref) {
    return downloadTemplateUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadTemplateUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadTemplateUsecase>(value),
    );
  }
}

String _$downloadTemplateUsecaseHash() =>
    r'f277ba5b36b8c690c6f8f96cf2d1571e4755bc33';

@ProviderFor(bulkUploadUsecase)
const bulkUploadUsecaseProvider = BulkUploadUsecaseProvider._();

final class BulkUploadUsecaseProvider
    extends
        $FunctionalProvider<
          BulkUploadUsecase,
          BulkUploadUsecase,
          BulkUploadUsecase
        >
    with $Provider<BulkUploadUsecase> {
  const BulkUploadUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bulkUploadUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bulkUploadUsecaseHash();

  @$internal
  @override
  $ProviderElement<BulkUploadUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BulkUploadUsecase create(Ref ref) {
    return bulkUploadUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BulkUploadUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BulkUploadUsecase>(value),
    );
  }
}

String _$bulkUploadUsecaseHash() => r'30e1c9fad5458ba19e73812103049fc50f7924d2';

@ProviderFor(deleteOrdersUseCase)
const deleteOrdersUseCaseProvider = DeleteOrdersUseCaseProvider._();

final class DeleteOrdersUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteOrdersUsecase,
          DeleteOrdersUsecase,
          DeleteOrdersUsecase
        >
    with $Provider<DeleteOrdersUsecase> {
  const DeleteOrdersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteOrdersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteOrdersUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteOrdersUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteOrdersUsecase create(Ref ref) {
    return deleteOrdersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteOrdersUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteOrdersUsecase>(value),
    );
  }
}

String _$deleteOrdersUseCaseHash() =>
    r'bf50b5d806ead0cf65faaea13e7265b4a507b207';
