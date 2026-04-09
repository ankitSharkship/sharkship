// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_orders_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateOrdersTab)
const createOrdersTabProvider = CreateOrdersTabProvider._();

final class CreateOrdersTabProvider
    extends $NotifierProvider<CreateOrdersTab, int> {
  const CreateOrdersTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createOrdersTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createOrdersTabHash();

  @$internal
  @override
  CreateOrdersTab create() => CreateOrdersTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$createOrdersTabHash() => r'71f0c10949afe3eb26154bec638d4fc1fbd2848b';

abstract class _$CreateOrdersTab extends $Notifier<int> {
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
