// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ndr_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ndrDataSource)
const ndrDataSourceProvider = NdrDataSourceProvider._();

final class NdrDataSourceProvider
    extends $FunctionalProvider<NdrDataSource, NdrDataSource, NdrDataSource>
    with $Provider<NdrDataSource> {
  const NdrDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ndrDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ndrDataSourceHash();

  @$internal
  @override
  $ProviderElement<NdrDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NdrDataSource create(Ref ref) {
    return ndrDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NdrDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NdrDataSource>(value),
    );
  }
}

String _$ndrDataSourceHash() => r'c8fb3eb26f78b0fbe07b3152a03c0ae95e5bde4f';

@ProviderFor(ndrRepository)
const ndrRepositoryProvider = NdrRepositoryProvider._();

final class NdrRepositoryProvider
    extends $FunctionalProvider<NdrRepository, NdrRepository, NdrRepository>
    with $Provider<NdrRepository> {
  const NdrRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ndrRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ndrRepositoryHash();

  @$internal
  @override
  $ProviderElement<NdrRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NdrRepository create(Ref ref) {
    return ndrRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NdrRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NdrRepository>(value),
    );
  }
}

String _$ndrRepositoryHash() => r'8014177102d061b4870539cfe48eb130eba4dde5';

@ProviderFor(getNdrOrdersUseCase)
const getNdrOrdersUseCaseProvider = GetNdrOrdersUseCaseProvider._();

final class GetNdrOrdersUseCaseProvider
    extends
        $FunctionalProvider<
          GetNdrOrdersUseCase,
          GetNdrOrdersUseCase,
          GetNdrOrdersUseCase
        >
    with $Provider<GetNdrOrdersUseCase> {
  const GetNdrOrdersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNdrOrdersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNdrOrdersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetNdrOrdersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetNdrOrdersUseCase create(Ref ref) {
    return getNdrOrdersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetNdrOrdersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetNdrOrdersUseCase>(value),
    );
  }
}

String _$getNdrOrdersUseCaseHash() =>
    r'da60673391446dc892fa1309fe06330fcf128d2a';

@ProviderFor(reattemptNdrOrdersUseCase)
const reattemptNdrOrdersUseCaseProvider = ReattemptNdrOrdersUseCaseProvider._();

final class ReattemptNdrOrdersUseCaseProvider
    extends
        $FunctionalProvider<
          ReattemptNdrOrdersUseCase,
          ReattemptNdrOrdersUseCase,
          ReattemptNdrOrdersUseCase
        >
    with $Provider<ReattemptNdrOrdersUseCase> {
  const ReattemptNdrOrdersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reattemptNdrOrdersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reattemptNdrOrdersUseCaseHash();

  @$internal
  @override
  $ProviderElement<ReattemptNdrOrdersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReattemptNdrOrdersUseCase create(Ref ref) {
    return reattemptNdrOrdersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReattemptNdrOrdersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReattemptNdrOrdersUseCase>(value),
    );
  }
}

String _$reattemptNdrOrdersUseCaseHash() =>
    r'9aec01b57c219d08177ee81edacd93fcaba090a0';
