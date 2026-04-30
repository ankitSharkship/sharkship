// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_label_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShippingLabelNotifier)
const shippingLabelProvider = ShippingLabelNotifierProvider._();

final class ShippingLabelNotifierProvider
    extends $AsyncNotifierProvider<ShippingLabelNotifier, ShippingLabelState> {
  const ShippingLabelNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shippingLabelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shippingLabelNotifierHash();

  @$internal
  @override
  ShippingLabelNotifier create() => ShippingLabelNotifier();
}

String _$shippingLabelNotifierHash() =>
    r'11fd62d42c3a7ec8369fc3535e00f4a4d15f6d79';

abstract class _$ShippingLabelNotifier
    extends $AsyncNotifier<ShippingLabelState> {
  FutureOr<ShippingLabelState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<ShippingLabelState>, ShippingLabelState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ShippingLabelState>, ShippingLabelState>,
              AsyncValue<ShippingLabelState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
