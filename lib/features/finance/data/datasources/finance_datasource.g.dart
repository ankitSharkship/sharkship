// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_datasource.dart';

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
