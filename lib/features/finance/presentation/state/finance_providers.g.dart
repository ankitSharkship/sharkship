// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(financeDataSource)
const financeDataSourceProvider = FinanceDataSourceProvider._();

final class FinanceDataSourceProvider
    extends
        $FunctionalProvider<
          FinanceDataSource,
          FinanceDataSource,
          FinanceDataSource
        >
    with $Provider<FinanceDataSource> {
  const FinanceDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financeDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financeDataSourceHash();

  @$internal
  @override
  $ProviderElement<FinanceDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FinanceDataSource create(Ref ref) {
    return financeDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinanceDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinanceDataSource>(value),
    );
  }
}

String _$financeDataSourceHash() => r'ce34bf6985cd7b5f1a212a08e5f418ff9234b4f5';

@ProviderFor(financeRepository)
const financeRepositoryProvider = FinanceRepositoryProvider._();

final class FinanceRepositoryProvider
    extends
        $FunctionalProvider<
          FinanceRepository,
          FinanceRepository,
          FinanceRepository
        >
    with $Provider<FinanceRepository> {
  const FinanceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financeRepositoryHash();

  @$internal
  @override
  $ProviderElement<FinanceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FinanceRepository create(Ref ref) {
    return financeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinanceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinanceRepository>(value),
    );
  }
}

String _$financeRepositoryHash() => r'823ba458d572ec7afd75874da3b31f80d2f82e8b';

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
    r'090d920eeacc090776b45608a94a6e900b792330';

@ProviderFor(calculateShippingRateUseCase)
const calculateShippingRateUseCaseProvider =
    CalculateShippingRateUseCaseProvider._();

final class CalculateShippingRateUseCaseProvider
    extends
        $FunctionalProvider<
          CalculateShippingRateUseCase,
          CalculateShippingRateUseCase,
          CalculateShippingRateUseCase
        >
    with $Provider<CalculateShippingRateUseCase> {
  const CalculateShippingRateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calculateShippingRateUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calculateShippingRateUseCaseHash();

  @$internal
  @override
  $ProviderElement<CalculateShippingRateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalculateShippingRateUseCase create(Ref ref) {
    return calculateShippingRateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalculateShippingRateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalculateShippingRateUseCase>(value),
    );
  }
}

String _$calculateShippingRateUseCaseHash() =>
    r'5d74ed669c90b7581ea60b38fdd3103aec910332';
