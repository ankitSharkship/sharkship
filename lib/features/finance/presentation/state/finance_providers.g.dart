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

@ProviderFor(getTransactionsUseCase)
const getTransactionsUseCaseProvider = GetTransactionsUseCaseProvider._();

final class GetTransactionsUseCaseProvider
    extends
        $FunctionalProvider<
          GetTransactionsUseCase,
          GetTransactionsUseCase,
          GetTransactionsUseCase
        >
    with $Provider<GetTransactionsUseCase> {
  const GetTransactionsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTransactionsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTransactionsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTransactionsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTransactionsUseCase create(Ref ref) {
    return getTransactionsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTransactionsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTransactionsUseCase>(value),
    );
  }
}

String _$getTransactionsUseCaseHash() =>
    r'd9fe2751193d03c8c904f9b293498cc06313c0a4';

@ProviderFor(getMessageMetricsUseCase)
const getMessageMetricsUseCaseProvider = GetMessageMetricsUseCaseProvider._();

final class GetMessageMetricsUseCaseProvider
    extends
        $FunctionalProvider<
          GetMessageMetricsUseCase,
          GetMessageMetricsUseCase,
          GetMessageMetricsUseCase
        >
    with $Provider<GetMessageMetricsUseCase> {
  const GetMessageMetricsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMessageMetricsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMessageMetricsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetMessageMetricsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetMessageMetricsUseCase create(Ref ref) {
    return getMessageMetricsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMessageMetricsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMessageMetricsUseCase>(value),
    );
  }
}

String _$getMessageMetricsUseCaseHash() =>
    r'd81b5a45e14fec0a73fe4e31d54833e8322b41aa';

@ProviderFor(getMessageTransactionsUseCase)
const getMessageTransactionsUseCaseProvider =
    GetMessageTransactionsUseCaseProvider._();

final class GetMessageTransactionsUseCaseProvider
    extends
        $FunctionalProvider<
          GetMessageTransactionsUseCase,
          GetMessageTransactionsUseCase,
          GetMessageTransactionsUseCase
        >
    with $Provider<GetMessageTransactionsUseCase> {
  const GetMessageTransactionsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMessageTransactionsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMessageTransactionsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetMessageTransactionsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetMessageTransactionsUseCase create(Ref ref) {
    return getMessageTransactionsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMessageTransactionsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMessageTransactionsUseCase>(
        value,
      ),
    );
  }
}

String _$getMessageTransactionsUseCaseHash() =>
    r'ea4c22936b1dcab3307475ca642b35819d167f31';

@ProviderFor(getRemittanceDetailsUseCase)
const getRemittanceDetailsUseCaseProvider =
    GetRemittanceDetailsUseCaseProvider._();

final class GetRemittanceDetailsUseCaseProvider
    extends
        $FunctionalProvider<
          GetRemittanceDetailsUseCase,
          GetRemittanceDetailsUseCase,
          GetRemittanceDetailsUseCase
        >
    with $Provider<GetRemittanceDetailsUseCase> {
  const GetRemittanceDetailsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRemittanceDetailsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRemittanceDetailsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRemittanceDetailsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRemittanceDetailsUseCase create(Ref ref) {
    return getRemittanceDetailsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRemittanceDetailsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRemittanceDetailsUseCase>(value),
    );
  }
}

String _$getRemittanceDetailsUseCaseHash() =>
    r'5d63689a3e38dafdb6cf7b77fa2831373199e935';

@ProviderFor(getRemittanceCyclesUseCase)
const getRemittanceCyclesUseCaseProvider =
    GetRemittanceCyclesUseCaseProvider._();

final class GetRemittanceCyclesUseCaseProvider
    extends
        $FunctionalProvider<
          GetRemittanceCyclesUseCase,
          GetRemittanceCyclesUseCase,
          GetRemittanceCyclesUseCase
        >
    with $Provider<GetRemittanceCyclesUseCase> {
  const GetRemittanceCyclesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRemittanceCyclesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRemittanceCyclesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRemittanceCyclesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRemittanceCyclesUseCase create(Ref ref) {
    return getRemittanceCyclesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRemittanceCyclesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRemittanceCyclesUseCase>(value),
    );
  }
}

String _$getRemittanceCyclesUseCaseHash() =>
    r'd53d5cfba090ae21ba6b316dad5807979f293b92';
