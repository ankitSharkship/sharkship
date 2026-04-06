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
    r'af64170ecfbfd0c386f8335a4309c3cc7aa6281d';

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
    r'fa9b040ba876358910130dc542022ac46bf8684e';

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

String _$ndrStatusNotifierHash() => r'8ca9bf231726a465322b82148284c2a7d5c08914';

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
    r'd6aad3711071dfa3ec7a41500a75d80faa8e350a';

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

/// -------------------------------
/// NDR Data Notifier (By Zone/Courier)
/// -------------------------------

@ProviderFor(NdrDataNotifier)
const ndrDataProvider = NdrDataNotifierProvider._();

/// -------------------------------
/// NDR Data Notifier (By Zone/Courier)
/// -------------------------------
final class NdrDataNotifierProvider
    extends $AsyncNotifierProvider<NdrDataNotifier, NdrData> {
  /// -------------------------------
  /// NDR Data Notifier (By Zone/Courier)
  /// -------------------------------
  const NdrDataNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ndrDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ndrDataNotifierHash();

  @$internal
  @override
  NdrDataNotifier create() => NdrDataNotifier();
}

String _$ndrDataNotifierHash() => r'b29d8fd42c7b194633e009c070a8af919f673465';

/// -------------------------------
/// NDR Data Notifier (By Zone/Courier)
/// -------------------------------

abstract class _$NdrDataNotifier extends $AsyncNotifier<NdrData> {
  FutureOr<NdrData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<NdrData>, NdrData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NdrData>, NdrData>,
              AsyncValue<NdrData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// -------------------------------
/// Datewise NDR Count Notifier
/// -------------------------------

@ProviderFor(DatewiseNdrCountNotifier)
const datewiseNdrCountProvider = DatewiseNdrCountNotifierProvider._();

/// -------------------------------
/// Datewise NDR Count Notifier
/// -------------------------------
final class DatewiseNdrCountNotifierProvider
    extends
        $AsyncNotifierProvider<
          DatewiseNdrCountNotifier,
          List<DatewiseNdrCount>
        > {
  /// -------------------------------
  /// Datewise NDR Count Notifier
  /// -------------------------------
  const DatewiseNdrCountNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'datewiseNdrCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$datewiseNdrCountNotifierHash();

  @$internal
  @override
  DatewiseNdrCountNotifier create() => DatewiseNdrCountNotifier();
}

String _$datewiseNdrCountNotifierHash() =>
    r'232e2318bec1d1b281ffff6a4549d57f939a5ce4';

/// -------------------------------
/// Datewise NDR Count Notifier
/// -------------------------------

abstract class _$DatewiseNdrCountNotifier
    extends $AsyncNotifier<List<DatewiseNdrCount>> {
  FutureOr<List<DatewiseNdrCount>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<DatewiseNdrCount>>, List<DatewiseNdrCount>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DatewiseNdrCount>>,
                List<DatewiseNdrCount>
              >,
              AsyncValue<List<DatewiseNdrCount>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
