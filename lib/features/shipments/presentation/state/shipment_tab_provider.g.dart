// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShipmentTab)
const shipmentTabProvider = ShipmentTabProvider._();

final class ShipmentTabProvider extends $NotifierProvider<ShipmentTab, int> {
  const ShipmentTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipmentTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipmentTabHash();

  @$internal
  @override
  ShipmentTab create() => ShipmentTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$shipmentTabHash() => r'82036ff9698215daa221ac692f4cf9f0d0e47bd1';

abstract class _$ShipmentTab extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
