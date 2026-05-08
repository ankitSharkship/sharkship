// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_billing_cycles.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getBillingCyclesUseCase)
const getBillingCyclesUseCaseProvider = GetBillingCyclesUseCaseProvider._();

final class GetBillingCyclesUseCaseProvider
    extends
        $FunctionalProvider<
          GetBillingCyclesUseCase,
          GetBillingCyclesUseCase,
          GetBillingCyclesUseCase
        >
    with $Provider<GetBillingCyclesUseCase> {
  const GetBillingCyclesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBillingCyclesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBillingCyclesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetBillingCyclesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetBillingCyclesUseCase create(Ref ref) {
    return getBillingCyclesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBillingCyclesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBillingCyclesUseCase>(value),
    );
  }
}

String _$getBillingCyclesUseCaseHash() =>
    r'1a74f92ce7df9c1ca5b41dde75ec8b5e310cb849';
