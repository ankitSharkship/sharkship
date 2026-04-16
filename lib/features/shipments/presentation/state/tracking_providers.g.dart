// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shipmentDataSource)
const shipmentDataSourceProvider = ShipmentDataSourceProvider._();

final class ShipmentDataSourceProvider
    extends
        $FunctionalProvider<
          ShipmentDataSource,
          ShipmentDataSource,
          ShipmentDataSource
        >
    with $Provider<ShipmentDataSource> {
  const ShipmentDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipmentDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipmentDataSourceHash();

  @$internal
  @override
  $ProviderElement<ShipmentDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShipmentDataSource create(Ref ref) {
    return shipmentDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShipmentDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShipmentDataSource>(value),
    );
  }
}

String _$shipmentDataSourceHash() =>
    r'e1cdfe12fe8dbb828d07f195bdf3d23c27224f4a';

@ProviderFor(shipmentRepository)
const shipmentRepositoryProvider = ShipmentRepositoryProvider._();

final class ShipmentRepositoryProvider
    extends
        $FunctionalProvider<
          ShipmentRepository,
          ShipmentRepository,
          ShipmentRepository
        >
    with $Provider<ShipmentRepository> {
  const ShipmentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipmentRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<ShipmentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShipmentRepository create(Ref ref) {
    return shipmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShipmentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShipmentRepository>(value),
    );
  }
}

String _$shipmentRepositoryHash() =>
    r'2d02420810dd898b4bebb65faac683e71c77638b';

@ProviderFor(getTrackingDetailsUseCase)
const getTrackingDetailsUseCaseProvider = GetTrackingDetailsUseCaseProvider._();

final class GetTrackingDetailsUseCaseProvider
    extends
        $FunctionalProvider<
          GetTrackingDetailsUseCase,
          GetTrackingDetailsUseCase,
          GetTrackingDetailsUseCase
        >
    with $Provider<GetTrackingDetailsUseCase> {
  const GetTrackingDetailsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTrackingDetailsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTrackingDetailsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTrackingDetailsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTrackingDetailsUseCase create(Ref ref) {
    return getTrackingDetailsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTrackingDetailsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTrackingDetailsUseCase>(value),
    );
  }
}

String _$getTrackingDetailsUseCaseHash() =>
    r'1dc8eacfc6567802ba941d28596e61668417b585';
