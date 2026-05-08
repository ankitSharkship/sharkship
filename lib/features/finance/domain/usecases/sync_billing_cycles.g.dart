// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_billing_cycles.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SyncBillingCyclesUseCase)
const syncBillingCyclesUseCaseProvider = SyncBillingCyclesUseCaseProvider._();

final class SyncBillingCyclesUseCaseProvider
    extends
        $NotifierProvider<SyncBillingCyclesUseCase, SyncBillingCyclesUseCase> {
  const SyncBillingCyclesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncBillingCyclesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncBillingCyclesUseCaseHash();

  @$internal
  @override
  SyncBillingCyclesUseCase create() => SyncBillingCyclesUseCase();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncBillingCyclesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncBillingCyclesUseCase>(value),
    );
  }
}

String _$syncBillingCyclesUseCaseHash() =>
    r'd7f97c76d607727cd0d63b1bc34b1111aeb67ea5';

abstract class _$SyncBillingCyclesUseCase
    extends $Notifier<SyncBillingCyclesUseCase> {
  SyncBillingCyclesUseCase build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<SyncBillingCyclesUseCase, SyncBillingCyclesUseCase>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SyncBillingCyclesUseCase, SyncBillingCyclesUseCase>,
              SyncBillingCyclesUseCase,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
