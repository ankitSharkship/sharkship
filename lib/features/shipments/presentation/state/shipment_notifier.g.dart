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
    extends $AsyncNotifierProvider<ShipmentNotifier, OrdersResponseEntity> {
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

String _$shipmentNotifierHash() => r'875be74d68730bf926cdf6c16832f499ec88ccef';

final class ShipmentNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ShipmentNotifier,
          AsyncValue<OrdersResponseEntity>,
          OrdersResponseEntity,
          FutureOr<OrdersResponseEntity>,
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

abstract class _$ShipmentNotifier extends $AsyncNotifier<OrdersResponseEntity> {
  late final _$args = ref.$arg as int;
  int get tabIndex => _$args;

  FutureOr<OrdersResponseEntity> build(int tabIndex);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<OrdersResponseEntity>, OrdersResponseEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<OrdersResponseEntity>,
                OrdersResponseEntity
              >,
              AsyncValue<OrdersResponseEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
