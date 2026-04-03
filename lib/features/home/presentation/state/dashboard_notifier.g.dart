// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// -------------------------------
/// Today Metrics Notifier
/// -------------------------------

@ProviderFor(TodayMetricsNotifier)
const todayMetricsProvider = TodayMetricsNotifierProvider._();

/// -------------------------------
/// Today Metrics Notifier
/// -------------------------------
final class TodayMetricsNotifierProvider
    extends $AsyncNotifierProvider<TodayMetricsNotifier, TodayMetrics> {
  /// -------------------------------
  /// Today Metrics Notifier
  /// -------------------------------
  const TodayMetricsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayMetricsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayMetricsNotifierHash();

  @$internal
  @override
  TodayMetricsNotifier create() => TodayMetricsNotifier();
}

String _$todayMetricsNotifierHash() =>
    r'9d7904d1bfa6b0c61cd4341f236a9124090f593b';

/// -------------------------------
/// Today Metrics Notifier
/// -------------------------------

abstract class _$TodayMetricsNotifier extends $AsyncNotifier<TodayMetrics> {
  FutureOr<TodayMetrics> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TodayMetrics>, TodayMetrics>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TodayMetrics>, TodayMetrics>,
              AsyncValue<TodayMetrics>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// -------------------------------
/// Order Status Notifier
/// -------------------------------

@ProviderFor(OrderStatusNotifier)
const orderStatusProvider = OrderStatusNotifierProvider._();

/// -------------------------------
/// Order Status Notifier
/// -------------------------------
final class OrderStatusNotifierProvider
    extends $AsyncNotifierProvider<OrderStatusNotifier, OrderStatusSummary> {
  /// -------------------------------
  /// Order Status Notifier
  /// -------------------------------
  const OrderStatusNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderStatusNotifierHash();

  @$internal
  @override
  OrderStatusNotifier create() => OrderStatusNotifier();
}

String _$orderStatusNotifierHash() =>
    r'aa15f778748291b13afb9689997b6e4449f9e1eb';

/// -------------------------------
/// Order Status Notifier
/// -------------------------------

abstract class _$OrderStatusNotifier
    extends $AsyncNotifier<OrderStatusSummary> {
  FutureOr<OrderStatusSummary> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<OrderStatusSummary>, OrderStatusSummary>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OrderStatusSummary>, OrderStatusSummary>,
              AsyncValue<OrderStatusSummary>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// -------------------------------
/// NDR Status Notifier
/// -------------------------------

@ProviderFor(NdrStatusNotifier)
const ndrStatusProvider = NdrStatusNotifierProvider._();

/// -------------------------------
/// NDR Status Notifier
/// -------------------------------
final class NdrStatusNotifierProvider
    extends $AsyncNotifierProvider<NdrStatusNotifier, NdrStatusSummary> {
  /// -------------------------------
  /// NDR Status Notifier
  /// -------------------------------
  const NdrStatusNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ndrStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ndrStatusNotifierHash();

  @$internal
  @override
  NdrStatusNotifier create() => NdrStatusNotifier();
}

String _$ndrStatusNotifierHash() => r'85d41103847107edd23b852c6fbe0cd3505bac6b';

/// -------------------------------
/// NDR Status Notifier
/// -------------------------------

abstract class _$NdrStatusNotifier extends $AsyncNotifier<NdrStatusSummary> {
  FutureOr<NdrStatusSummary> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<NdrStatusSummary>, NdrStatusSummary>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NdrStatusSummary>, NdrStatusSummary>,
              AsyncValue<NdrStatusSummary>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CourierPickupNotifier)
const courierPickupProvider = CourierPickupNotifierProvider._();

final class CourierPickupNotifierProvider
    extends
        $AsyncNotifierProvider<
          CourierPickupNotifier,
          CarrierPickupSummaryList
        > {
  const CourierPickupNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courierPickupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courierPickupNotifierHash();

  @$internal
  @override
  CourierPickupNotifier create() => CourierPickupNotifier();
}

String _$courierPickupNotifierHash() =>
    r'85fbfea9ca230dece5b9e939f6ec93d667cf8244';

abstract class _$CourierPickupNotifier
    extends $AsyncNotifier<CarrierPickupSummaryList> {
  FutureOr<CarrierPickupSummaryList> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CarrierPickupSummaryList>,
              CarrierPickupSummaryList
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CarrierPickupSummaryList>,
                CarrierPickupSummaryList
              >,
              AsyncValue<CarrierPickupSummaryList>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
