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

@ProviderFor(shipOrdersUsecase)
const shipOrdersUsecaseProvider = ShipOrdersUsecaseProvider._();

final class ShipOrdersUsecaseProvider
    extends
        $FunctionalProvider<
          ShipOrdersUsecase,
          ShipOrdersUsecase,
          ShipOrdersUsecase
        >
    with $Provider<ShipOrdersUsecase> {
  const ShipOrdersUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipOrdersUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipOrdersUsecaseHash();

  @$internal
  @override
  $ProviderElement<ShipOrdersUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShipOrdersUsecase create(Ref ref) {
    return shipOrdersUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShipOrdersUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShipOrdersUsecase>(value),
    );
  }
}

String _$shipOrdersUsecaseHash() => r'd81493faf26b2537b6470a1a22b65a3b599472f9';

@ProviderFor(getCourierPriorityUseCase)
const getCourierPriorityUseCaseProvider = GetCourierPriorityUseCaseProvider._();

final class GetCourierPriorityUseCaseProvider
    extends
        $FunctionalProvider<
          GetCourierPriorityUseCase,
          GetCourierPriorityUseCase,
          GetCourierPriorityUseCase
        >
    with $Provider<GetCourierPriorityUseCase> {
  const GetCourierPriorityUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCourierPriorityUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCourierPriorityUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCourierPriorityUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCourierPriorityUseCase create(Ref ref) {
    return getCourierPriorityUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCourierPriorityUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCourierPriorityUseCase>(value),
    );
  }
}

String _$getCourierPriorityUseCaseHash() =>
    r'cf9e8b71c705edf91f42b18b46f1f30e4fb7e6b9';

@ProviderFor(getCourierPartnersUseCase)
const getCourierPartnersUseCaseProvider = GetCourierPartnersUseCaseProvider._();

final class GetCourierPartnersUseCaseProvider
    extends
        $FunctionalProvider<
          GetCourierPartnersUseCase,
          GetCourierPartnersUseCase,
          GetCourierPartnersUseCase
        >
    with $Provider<GetCourierPartnersUseCase> {
  const GetCourierPartnersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCourierPartnersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCourierPartnersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCourierPartnersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCourierPartnersUseCase create(Ref ref) {
    return getCourierPartnersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCourierPartnersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCourierPartnersUseCase>(value),
    );
  }
}

String _$getCourierPartnersUseCaseHash() =>
    r'fe0b6557ff8aca00b0dbc84f4c746c8d093f0896';

@ProviderFor(updateCourierPriorityUseCase)
const updateCourierPriorityUseCaseProvider =
    UpdateCourierPriorityUseCaseProvider._();

final class UpdateCourierPriorityUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateCourierPriorityUseCase,
          UpdateCourierPriorityUseCase,
          UpdateCourierPriorityUseCase
        >
    with $Provider<UpdateCourierPriorityUseCase> {
  const UpdateCourierPriorityUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateCourierPriorityUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateCourierPriorityUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateCourierPriorityUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateCourierPriorityUseCase create(Ref ref) {
    return updateCourierPriorityUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateCourierPriorityUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateCourierPriorityUseCase>(value),
    );
  }
}

String _$updateCourierPriorityUseCaseHash() =>
    r'4be2218a354b7b68bfb292c5d6c55583262584ad';

@ProviderFor(setDefaultPickupAddressUseCase)
const setDefaultPickupAddressUseCaseProvider =
    SetDefaultPickupAddressUseCaseProvider._();

final class SetDefaultPickupAddressUseCaseProvider
    extends
        $FunctionalProvider<
          SetDefaultPickupAddressUseCase,
          SetDefaultPickupAddressUseCase,
          SetDefaultPickupAddressUseCase
        >
    with $Provider<SetDefaultPickupAddressUseCase> {
  const SetDefaultPickupAddressUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setDefaultPickupAddressUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setDefaultPickupAddressUseCaseHash();

  @$internal
  @override
  $ProviderElement<SetDefaultPickupAddressUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SetDefaultPickupAddressUseCase create(Ref ref) {
    return setDefaultPickupAddressUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetDefaultPickupAddressUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetDefaultPickupAddressUseCase>(
        value,
      ),
    );
  }
}

String _$setDefaultPickupAddressUseCaseHash() =>
    r'c0c8b32c1f9495c263b06aa7d1d981f201ab3ec0';

@ProviderFor(exportOrdersUseCase)
const exportOrdersUseCaseProvider = ExportOrdersUseCaseProvider._();

final class ExportOrdersUseCaseProvider
    extends
        $FunctionalProvider<
          ExportOrdersUseCase,
          ExportOrdersUseCase,
          ExportOrdersUseCase
        >
    with $Provider<ExportOrdersUseCase> {
  const ExportOrdersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportOrdersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportOrdersUseCaseHash();

  @$internal
  @override
  $ProviderElement<ExportOrdersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExportOrdersUseCase create(Ref ref) {
    return exportOrdersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExportOrdersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExportOrdersUseCase>(value),
    );
  }
}

String _$exportOrdersUseCaseHash() =>
    r'f2b9956d2b2060115533879874797672ad325c19';

@ProviderFor(editOrderUseCase)
const editOrderUseCaseProvider = EditOrderUseCaseProvider._();

final class EditOrderUseCaseProvider
    extends
        $FunctionalProvider<
          EditOrderUseCase,
          EditOrderUseCase,
          EditOrderUseCase
        >
    with $Provider<EditOrderUseCase> {
  const EditOrderUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editOrderUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editOrderUseCaseHash();

  @$internal
  @override
  $ProviderElement<EditOrderUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EditOrderUseCase create(Ref ref) {
    return editOrderUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditOrderUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditOrderUseCase>(value),
    );
  }
}

String _$editOrderUseCaseHash() => r'0453c1f7bac6d7c3ed268adfef2d6d030d5f3962';

@ProviderFor(downloadShippingLabelUseCase)
const downloadShippingLabelUseCaseProvider =
    DownloadShippingLabelUseCaseProvider._();

final class DownloadShippingLabelUseCaseProvider
    extends
        $FunctionalProvider<
          DownloadShippingLabelUseCase,
          DownloadShippingLabelUseCase,
          DownloadShippingLabelUseCase
        >
    with $Provider<DownloadShippingLabelUseCase> {
  const DownloadShippingLabelUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadShippingLabelUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadShippingLabelUseCaseHash();

  @$internal
  @override
  $ProviderElement<DownloadShippingLabelUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DownloadShippingLabelUseCase create(Ref ref) {
    return downloadShippingLabelUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadShippingLabelUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadShippingLabelUseCase>(value),
    );
  }
}

String _$downloadShippingLabelUseCaseHash() =>
    r'ef74ed4ff9606ccd41a8a083d76db65d1da0167b';

@ProviderFor(downloadOrderInvoiceUseCase)
const downloadOrderInvoiceUseCaseProvider =
    DownloadOrderInvoiceUseCaseProvider._();

final class DownloadOrderInvoiceUseCaseProvider
    extends
        $FunctionalProvider<
          DownloadOrderInvoiceUseCase,
          DownloadOrderInvoiceUseCase,
          DownloadOrderInvoiceUseCase
        >
    with $Provider<DownloadOrderInvoiceUseCase> {
  const DownloadOrderInvoiceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadOrderInvoiceUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadOrderInvoiceUseCaseHash();

  @$internal
  @override
  $ProviderElement<DownloadOrderInvoiceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DownloadOrderInvoiceUseCase create(Ref ref) {
    return downloadOrderInvoiceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadOrderInvoiceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadOrderInvoiceUseCase>(value),
    );
  }
}

String _$downloadOrderInvoiceUseCaseHash() =>
    r'552ead393484abcec112de28b12696358ce737bf';

@ProviderFor(generateManifestationUseCase)
const generateManifestationUseCaseProvider =
    GenerateManifestationUseCaseProvider._();

final class GenerateManifestationUseCaseProvider
    extends
        $FunctionalProvider<
          GenerateManifestationUseCase,
          GenerateManifestationUseCase,
          GenerateManifestationUseCase
        >
    with $Provider<GenerateManifestationUseCase> {
  const GenerateManifestationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generateManifestationUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generateManifestationUseCaseHash();

  @$internal
  @override
  $ProviderElement<GenerateManifestationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GenerateManifestationUseCase create(Ref ref) {
    return generateManifestationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerateManifestationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerateManifestationUseCase>(value),
    );
  }
}

String _$generateManifestationUseCaseHash() =>
    r'5137162fe1b9d207d79bcb564db3f48d01043c69';

@ProviderFor(cancelOrdersUseCase)
const cancelOrdersUseCaseProvider = CancelOrdersUseCaseProvider._();

final class CancelOrdersUseCaseProvider
    extends
        $FunctionalProvider<
          CancelOrdersUseCase,
          CancelOrdersUseCase,
          CancelOrdersUseCase
        >
    with $Provider<CancelOrdersUseCase> {
  const CancelOrdersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cancelOrdersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cancelOrdersUseCaseHash();

  @$internal
  @override
  $ProviderElement<CancelOrdersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CancelOrdersUseCase create(Ref ref) {
    return cancelOrdersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CancelOrdersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CancelOrdersUseCase>(value),
    );
  }
}

String _$cancelOrdersUseCaseHash() =>
    r'54567d03520307b0540b51f0d9e3e12caaaaa115';

@ProviderFor(cloneOrderUseCase)
const cloneOrderUseCaseProvider = CloneOrderUseCaseProvider._();

final class CloneOrderUseCaseProvider
    extends
        $FunctionalProvider<
          CloneOrderUseCase,
          CloneOrderUseCase,
          CloneOrderUseCase
        >
    with $Provider<CloneOrderUseCase> {
  const CloneOrderUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cloneOrderUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cloneOrderUseCaseHash();

  @$internal
  @override
  $ProviderElement<CloneOrderUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CloneOrderUseCase create(Ref ref) {
    return cloneOrderUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloneOrderUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloneOrderUseCase>(value),
    );
  }
}

String _$cloneOrderUseCaseHash() => r'd2141d10e0805801b0cba7f428396dd992b4cda8';
