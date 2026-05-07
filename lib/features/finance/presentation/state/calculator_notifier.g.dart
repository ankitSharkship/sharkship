// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CalculatorNotifier)
const calculatorProvider = CalculatorNotifierProvider._();

final class CalculatorNotifierProvider
    extends
        $NotifierProvider<
          CalculatorNotifier,
          AsyncValue<List<CalculatorRateEntity>>
        > {
  const CalculatorNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calculatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calculatorNotifierHash();

  @$internal
  @override
  CalculatorNotifier create() => CalculatorNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<CalculatorRateEntity>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AsyncValue<List<CalculatorRateEntity>>>(value),
    );
  }
}

String _$calculatorNotifierHash() =>
    r'78fb84b1f098629272a5b27e49fcc1ce199130ad';

abstract class _$CalculatorNotifier
    extends $Notifier<AsyncValue<List<CalculatorRateEntity>>> {
  AsyncValue<List<CalculatorRateEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<CalculatorRateEntity>>,
              AsyncValue<List<CalculatorRateEntity>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CalculatorRateEntity>>,
                AsyncValue<List<CalculatorRateEntity>>
              >,
              AsyncValue<List<CalculatorRateEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
