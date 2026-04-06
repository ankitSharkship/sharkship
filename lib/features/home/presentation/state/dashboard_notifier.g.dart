// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodayMetricsNotifier)
const todayMetricsProvider = TodayMetricsNotifierProvider._();

final class TodayMetricsNotifierProvider
    extends $AsyncNotifierProvider<TodayMetricsNotifier, TodayMetrics> {
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

@ProviderFor(OrderStatusNotifier)
const orderStatusProvider = OrderStatusNotifierProvider._();

final class OrderStatusNotifierProvider
    extends $AsyncNotifierProvider<OrderStatusNotifier, OrderStatusSummary> {
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

@ProviderFor(NdrStatusNotifier)
const ndrStatusProvider = NdrStatusNotifierProvider._();

final class NdrStatusNotifierProvider
    extends $AsyncNotifierProvider<NdrStatusNotifier, NdrStatusSummary> {
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

@ProviderFor(NdrData)
const ndrDataProvider = NdrDataProvider._();

final class NdrDataProvider
    extends $AsyncNotifierProvider<NdrData, NdrDataEntity.NdrData> {
  const NdrDataProvider._()
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
  String debugGetCreateSourceHash() => _$ndrDataHash();

  @$internal
  @override
  NdrData create() => NdrData();
}

String _$ndrDataHash() => r'0f2805a9cf73a34c5184a8da4cb7b7a1bdbd51d7';

abstract class _$NdrData extends $AsyncNotifier<NdrDataEntity.NdrData> {
  FutureOr<NdrDataEntity.NdrData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<NdrDataEntity.NdrData>, NdrDataEntity.NdrData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NdrDataEntity.NdrData>,
                NdrDataEntity.NdrData
              >,
              AsyncValue<NdrDataEntity.NdrData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DatewiseNdrCount)
const datewiseNdrCountProvider = DatewiseNdrCountProvider._();

final class DatewiseNdrCountProvider
    extends
        $AsyncNotifierProvider<
          DatewiseNdrCount,
          List<DatewiseNdrCountEntity.DatewiseNdrCount>
        > {
  const DatewiseNdrCountProvider._()
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
  String debugGetCreateSourceHash() => _$datewiseNdrCountHash();

  @$internal
  @override
  DatewiseNdrCount create() => DatewiseNdrCount();
}

String _$datewiseNdrCountHash() => r'7e6a59cfad3503c4f2491673727176b9c8cf8f50';

abstract class _$DatewiseNdrCount
    extends $AsyncNotifier<List<DatewiseNdrCountEntity.DatewiseNdrCount>> {
  FutureOr<List<DatewiseNdrCountEntity.DatewiseNdrCount>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DatewiseNdrCountEntity.DatewiseNdrCount>>,
              List<DatewiseNdrCountEntity.DatewiseNdrCount>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DatewiseNdrCountEntity.DatewiseNdrCount>>,
                List<DatewiseNdrCountEntity.DatewiseNdrCount>
              >,
              AsyncValue<List<DatewiseNdrCountEntity.DatewiseNdrCount>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TopRtoData)
const topRtoDataProvider = TopRtoDataProvider._();

final class TopRtoDataProvider
    extends $AsyncNotifierProvider<TopRtoData, TopRtoDataEntity.TopRtoData> {
  const TopRtoDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'topRtoDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$topRtoDataHash();

  @$internal
  @override
  TopRtoData create() => TopRtoData();
}

String _$topRtoDataHash() => r'3b682cb59b081a14797cc8694075ba43a311d0c0';

abstract class _$TopRtoData
    extends $AsyncNotifier<TopRtoDataEntity.TopRtoData> {
  FutureOr<TopRtoDataEntity.TopRtoData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<TopRtoDataEntity.TopRtoData>,
              TopRtoDataEntity.TopRtoData
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TopRtoDataEntity.TopRtoData>,
                TopRtoDataEntity.TopRtoData
              >,
              AsyncValue<TopRtoDataEntity.TopRtoData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DatewiseRtoCount)
const datewiseRtoCountProvider = DatewiseRtoCountProvider._();

final class DatewiseRtoCountProvider
    extends
        $AsyncNotifierProvider<
          DatewiseRtoCount,
          List<DatewiseRtoCountEntity.DatewiseRtoCount>
        > {
  const DatewiseRtoCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'datewiseRtoCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$datewiseRtoCountHash();

  @$internal
  @override
  DatewiseRtoCount create() => DatewiseRtoCount();
}

String _$datewiseRtoCountHash() => r'c62cf1967c0f86972ccd9257f656475189ff04c2';

abstract class _$DatewiseRtoCount
    extends $AsyncNotifier<List<DatewiseRtoCountEntity.DatewiseRtoCount>> {
  FutureOr<List<DatewiseRtoCountEntity.DatewiseRtoCount>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DatewiseRtoCountEntity.DatewiseRtoCount>>,
              List<DatewiseRtoCountEntity.DatewiseRtoCount>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DatewiseRtoCountEntity.DatewiseRtoCount>>,
                List<DatewiseRtoCountEntity.DatewiseRtoCount>
              >,
              AsyncValue<List<DatewiseRtoCountEntity.DatewiseRtoCount>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TopDeliveredData)
const topDeliveredDataProvider = TopDeliveredDataProvider._();

final class TopDeliveredDataProvider
    extends
        $AsyncNotifierProvider<
          TopDeliveredData,
          TopDeliveredDataEntity.TopDeliveredData
        > {
  const TopDeliveredDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'topDeliveredDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$topDeliveredDataHash();

  @$internal
  @override
  TopDeliveredData create() => TopDeliveredData();
}

String _$topDeliveredDataHash() => r'4c7452ac2dc6d44d9a561692f2ce1a4d7201d976';

abstract class _$TopDeliveredData
    extends $AsyncNotifier<TopDeliveredDataEntity.TopDeliveredData> {
  FutureOr<TopDeliveredDataEntity.TopDeliveredData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<TopDeliveredDataEntity.TopDeliveredData>,
              TopDeliveredDataEntity.TopDeliveredData
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TopDeliveredDataEntity.TopDeliveredData>,
                TopDeliveredDataEntity.TopDeliveredData
              >,
              AsyncValue<TopDeliveredDataEntity.TopDeliveredData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CodData)
const codDataProvider = CodDataProvider._();

final class CodDataProvider
    extends $AsyncNotifierProvider<CodData, List<CodDataEntity.CodData>> {
  const CodDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'codDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$codDataHash();

  @$internal
  @override
  CodData create() => CodData();
}

String _$codDataHash() => r'fe04092d0870ff13bd271213b36e920cc89a58b2';

abstract class _$CodData extends $AsyncNotifier<List<CodDataEntity.CodData>> {
  FutureOr<List<CodDataEntity.CodData>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<CodDataEntity.CodData>>,
              List<CodDataEntity.CodData>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CodDataEntity.CodData>>,
                List<CodDataEntity.CodData>
              >,
              AsyncValue<List<CodDataEntity.CodData>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(OrderRevenue)
const orderRevenueProvider = OrderRevenueProvider._();

final class OrderRevenueProvider
    extends
        $AsyncNotifierProvider<OrderRevenue, OrderRevenueEntity.OrderRevenue> {
  const OrderRevenueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderRevenueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderRevenueHash();

  @$internal
  @override
  OrderRevenue create() => OrderRevenue();
}

String _$orderRevenueHash() => r'f94758361ddd70ffba5134d4c35f2f2fedbfab88';

abstract class _$OrderRevenue
    extends $AsyncNotifier<OrderRevenueEntity.OrderRevenue> {
  FutureOr<OrderRevenueEntity.OrderRevenue> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<OrderRevenueEntity.OrderRevenue>,
              OrderRevenueEntity.OrderRevenue
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<OrderRevenueEntity.OrderRevenue>,
                OrderRevenueEntity.OrderRevenue
              >,
              AsyncValue<OrderRevenueEntity.OrderRevenue>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
