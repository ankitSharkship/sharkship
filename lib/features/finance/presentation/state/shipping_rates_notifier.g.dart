// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_rates_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShippingRatesNotifier)
const shippingRatesProvider = ShippingRatesNotifierProvider._();

final class ShippingRatesNotifierProvider
    extends
        $AsyncNotifierProvider<
          ShippingRatesNotifier,
          List<ShippingRateEntity>
        > {
  const ShippingRatesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shippingRatesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shippingRatesNotifierHash();

  @$internal
  @override
  ShippingRatesNotifier create() => ShippingRatesNotifier();
}

String _$shippingRatesNotifierHash() =>
    r'26b31dea3a355d6313b0695e3423b58305b0978a';

abstract class _$ShippingRatesNotifier
    extends $AsyncNotifier<List<ShippingRateEntity>> {
  FutureOr<List<ShippingRateEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ShippingRateEntity>>,
              List<ShippingRateEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ShippingRateEntity>>,
                List<ShippingRateEntity>
              >,
              AsyncValue<List<ShippingRateEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
