// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wd_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(wdDataSource)
const wdDataSourceProvider = WdDataSourceProvider._();

final class WdDataSourceProvider
    extends $FunctionalProvider<WdDataSource, WdDataSource, WdDataSource>
    with $Provider<WdDataSource> {
  const WdDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wdDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wdDataSourceHash();

  @$internal
  @override
  $ProviderElement<WdDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WdDataSource create(Ref ref) {
    return wdDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WdDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WdDataSource>(value),
    );
  }
}

String _$wdDataSourceHash() => r'98a7dc299238e6e236e672e4d921d2af720374b1';

@ProviderFor(wdRepository)
const wdRepositoryProvider = WdRepositoryProvider._();

final class WdRepositoryProvider
    extends $FunctionalProvider<WdRepository, WdRepository, WdRepository>
    with $Provider<WdRepository> {
  const WdRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wdRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wdRepositoryHash();

  @$internal
  @override
  $ProviderElement<WdRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WdRepository create(Ref ref) {
    return wdRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WdRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WdRepository>(value),
    );
  }
}

String _$wdRepositoryHash() => r'911653c9c957116960bc43ac9199dc13de36da70';

@ProviderFor(getWdUsecase)
const getWdUsecaseProvider = GetWdUsecaseProvider._();

final class GetWdUsecaseProvider
    extends $FunctionalProvider<GetWdUsecase, GetWdUsecase, GetWdUsecase>
    with $Provider<GetWdUsecase> {
  const GetWdUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWdUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWdUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetWdUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetWdUsecase create(Ref ref) {
    return getWdUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWdUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWdUsecase>(value),
    );
  }
}

String _$getWdUsecaseHash() => r'e518be8521f384232aac0059c166c00a2cce2052';

@ProviderFor(uploadDisputeUseCase)
const uploadDisputeUseCaseProvider = UploadDisputeUseCaseProvider._();

final class UploadDisputeUseCaseProvider
    extends
        $FunctionalProvider<
          UploadDisputeUseCase,
          UploadDisputeUseCase,
          UploadDisputeUseCase
        >
    with $Provider<UploadDisputeUseCase> {
  const UploadDisputeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadDisputeUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadDisputeUseCaseHash();

  @$internal
  @override
  $ProviderElement<UploadDisputeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UploadDisputeUseCase create(Ref ref) {
    return uploadDisputeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadDisputeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadDisputeUseCase>(value),
    );
  }
}

String _$uploadDisputeUseCaseHash() =>
    r'86297de8beeb0efff8232f84d3910af211d1ca41';
