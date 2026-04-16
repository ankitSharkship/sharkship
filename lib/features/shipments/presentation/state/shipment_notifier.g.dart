// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShipmentNotifier)
const shipmentProvider = ShipmentNotifierFamily._();

final class ShipmentNotifierProvider
    extends $AsyncNotifierProvider<ShipmentNotifier, ShipmentState> {
  const ShipmentNotifierProvider._({
    required ShipmentNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'shipmentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$shipmentNotifierHash();

  @override
  String toString() {
    return r'shipmentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ShipmentNotifier create() => ShipmentNotifier();

  @override
  bool operator ==(Object other) {
    return other is ShipmentNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$shipmentNotifierHash() => r'2c0394a1eeb70d29a42af6424ed5d7c964f615b0';

final class ShipmentNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ShipmentNotifier,
          AsyncValue<ShipmentState>,
          ShipmentState,
          FutureOr<ShipmentState>,
          int
        > {
  const ShipmentNotifierFamily._()
    : super(
        retry: null,
        name: r'shipmentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ShipmentNotifierProvider call(int tabIndex) =>
      ShipmentNotifierProvider._(argument: tabIndex, from: this);

  @override
  String toString() => r'shipmentProvider';
}

abstract class _$ShipmentNotifier extends $AsyncNotifier<ShipmentState> {
  late final _$args = ref.$arg as int;
  int get tabIndex => _$args;

  FutureOr<ShipmentState> build(int tabIndex);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ShipmentState>, ShipmentState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ShipmentState>, ShipmentState>,
              AsyncValue<ShipmentState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
