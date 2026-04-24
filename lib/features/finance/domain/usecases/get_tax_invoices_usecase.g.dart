// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tax_invoices_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getTaxInvoicesUseCase)
const getTaxInvoicesUseCaseProvider = GetTaxInvoicesUseCaseProvider._();

final class GetTaxInvoicesUseCaseProvider
    extends
        $FunctionalProvider<
          GetTaxInvoicesUseCase,
          GetTaxInvoicesUseCase,
          GetTaxInvoicesUseCase
        >
    with $Provider<GetTaxInvoicesUseCase> {
  const GetTaxInvoicesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTaxInvoicesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTaxInvoicesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTaxInvoicesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTaxInvoicesUseCase create(Ref ref) {
    return getTaxInvoicesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTaxInvoicesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTaxInvoicesUseCase>(value),
    );
  }
}

String _$getTaxInvoicesUseCaseHash() =>
    r'ad408c0a20f15add8dd74482cdec7cf5e0259049';
