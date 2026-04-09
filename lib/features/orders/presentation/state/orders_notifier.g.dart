// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OrdersNotifier)
const ordersProvider = OrdersNotifierFamily._();

final class OrdersNotifierProvider
    extends $AsyncNotifierProvider<OrdersNotifier, OrdersResponseEntity> {
  const OrdersNotifierProvider._({
    required OrdersNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'ordersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ordersNotifierHash();

  @override
  String toString() {
    return r'ordersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OrdersNotifier create() => OrdersNotifier();

  @override
  bool operator ==(Object other) {
    return other is OrdersNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ordersNotifierHash() => r'e30041e57aa35d11776d57548debfc20c1a82e64';

final class OrdersNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          OrdersNotifier,
          AsyncValue<OrdersResponseEntity>,
          OrdersResponseEntity,
          FutureOr<OrdersResponseEntity>,
          int
        > {
  const OrdersNotifierFamily._()
    : super(
        retry: null,
        name: r'ordersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrdersNotifierProvider call(int tabIndex) =>
      OrdersNotifierProvider._(argument: tabIndex, from: this);

  @override
  String toString() => r'ordersProvider';
}

abstract class _$OrdersNotifier extends $AsyncNotifier<OrdersResponseEntity> {
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
