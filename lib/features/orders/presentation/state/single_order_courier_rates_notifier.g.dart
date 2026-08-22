// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_order_courier_rates_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches live courier rates for a specific order + pickup address, used
/// only by the single-order ship flow's "Select Courier" step.

@ProviderFor(singleOrderCourierRates)
const singleOrderCourierRatesProvider = SingleOrderCourierRatesFamily._();

/// Fetches live courier rates for a specific order + pickup address, used
/// only by the single-order ship flow's "Select Courier" step.

final class SingleOrderCourierRatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<OrderCourierRatesEntity>,
          OrderCourierRatesEntity,
          FutureOr<OrderCourierRatesEntity>
        >
    with
        $FutureModifier<OrderCourierRatesEntity>,
        $FutureProvider<OrderCourierRatesEntity> {
  /// Fetches live courier rates for a specific order + pickup address, used
  /// only by the single-order ship flow's "Select Courier" step.
  const SingleOrderCourierRatesProvider._({
    required SingleOrderCourierRatesFamily super.from,
    required (int, int) super.argument,
  }) : super(
         retry: null,
         name: r'singleOrderCourierRatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$singleOrderCourierRatesHash();

  @override
  String toString() {
    return r'singleOrderCourierRatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<OrderCourierRatesEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OrderCourierRatesEntity> create(Ref ref) {
    final argument = this.argument as (int, int);
    return singleOrderCourierRates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleOrderCourierRatesProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$singleOrderCourierRatesHash() =>
    r'7693224c94c0d812676aac030aab07c14b65f48a';

/// Fetches live courier rates for a specific order + pickup address, used
/// only by the single-order ship flow's "Select Courier" step.

final class SingleOrderCourierRatesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<OrderCourierRatesEntity>,
          (int, int)
        > {
  const SingleOrderCourierRatesFamily._()
    : super(
        retry: null,
        name: r'singleOrderCourierRatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fetches live courier rates for a specific order + pickup address, used
  /// only by the single-order ship flow's "Select Courier" step.

  SingleOrderCourierRatesProvider call((int, int) key) =>
      SingleOrderCourierRatesProvider._(argument: key, from: this);

  @override
  String toString() => r'singleOrderCourierRatesProvider';
}
