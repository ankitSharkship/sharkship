// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OrdersTab)
const ordersTabProvider = OrdersTabProvider._();

final class OrdersTabProvider extends $NotifierProvider<OrdersTab, int> {
  const OrdersTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersTabHash();

  @$internal
  @override
  OrdersTab create() => OrdersTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$ordersTabHash() => r'c4c876db412cd94144eebfd48ccbb1fe518c64ea';

abstract class _$OrdersTab extends $Notifier<int> {
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
