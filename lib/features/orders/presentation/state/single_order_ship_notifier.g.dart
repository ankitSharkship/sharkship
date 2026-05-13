// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_order_ship_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SingleOrderShipNotifier)
const singleOrderShipProvider = SingleOrderShipNotifierFamily._();

final class SingleOrderShipNotifierProvider
    extends $NotifierProvider<SingleOrderShipNotifier, SingleOrderShipState> {
  const SingleOrderShipNotifierProvider._({
    required SingleOrderShipNotifierFamily super.from,
    required OrderEntity super.argument,
  }) : super(
         retry: null,
         name: r'singleOrderShipProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$singleOrderShipNotifierHash();

  @override
  String toString() {
    return r'singleOrderShipProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SingleOrderShipNotifier create() => SingleOrderShipNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SingleOrderShipState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SingleOrderShipState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SingleOrderShipNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$singleOrderShipNotifierHash() =>
    r'411af8f75fe1028ae333e196daf8baa787e071c3';

final class SingleOrderShipNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SingleOrderShipNotifier,
          SingleOrderShipState,
          SingleOrderShipState,
          SingleOrderShipState,
          OrderEntity
        > {
  const SingleOrderShipNotifierFamily._()
    : super(
        retry: null,
        name: r'singleOrderShipProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SingleOrderShipNotifierProvider call(OrderEntity initialOrder) =>
      SingleOrderShipNotifierProvider._(argument: initialOrder, from: this);

  @override
  String toString() => r'singleOrderShipProvider';
}

abstract class _$SingleOrderShipNotifier
    extends $Notifier<SingleOrderShipState> {
  late final _$args = ref.$arg as OrderEntity;
  OrderEntity get initialOrder => _$args;

  SingleOrderShipState build(OrderEntity initialOrder);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<SingleOrderShipState, SingleOrderShipState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SingleOrderShipState, SingleOrderShipState>,
              SingleOrderShipState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
