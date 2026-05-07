// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardDate)
const dashboardDateProvider = DashboardDateProvider._();

final class DashboardDateProvider
    extends $NotifierProvider<DashboardDate, DateTimeRange<DateTime>> {
  const DashboardDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardDateHash();

  @$internal
  @override
  DashboardDate create() => DashboardDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTimeRange<DateTime> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTimeRange<DateTime>>(value),
    );
  }
}

String _$dashboardDateHash() => r'662908153c4e4154d522f61e45422612b76eb04b';

abstract class _$DashboardDate extends $Notifier<DateTimeRange<DateTime>> {
  DateTimeRange<DateTime> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<DateTimeRange<DateTime>, DateTimeRange<DateTime>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTimeRange<DateTime>, DateTimeRange<DateTime>>,
              DateTimeRange<DateTime>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TodayMetrics)
const todayMetricsProvider = TodayMetricsProvider._();

final class TodayMetricsProvider
    extends $AsyncNotifierProvider<TodayMetrics, tm.TodayMetrics> {
  const TodayMetricsProvider._()
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
  String debugGetCreateSourceHash() => _$todayMetricsHash();

  @$internal
  @override
  TodayMetrics create() => TodayMetrics();
}

String _$todayMetricsHash() => r'453f9adf196fca8f59f0ed17982b94f9baa94a85';

abstract class _$TodayMetrics extends $AsyncNotifier<tm.TodayMetrics> {
  FutureOr<tm.TodayMetrics> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<tm.TodayMetrics>, tm.TodayMetrics>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<tm.TodayMetrics>, tm.TodayMetrics>,
              AsyncValue<tm.TodayMetrics>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(OrderStatus)
const orderStatusProvider = OrderStatusProvider._();

final class OrderStatusProvider
    extends $AsyncNotifierProvider<OrderStatus, OrderStatusSummary> {
  const OrderStatusProvider._()
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
  String debugGetCreateSourceHash() => _$orderStatusHash();

  @$internal
  @override
  OrderStatus create() => OrderStatus();
}

String _$orderStatusHash() => r'650d99987a1cb7d41f201d66127fabf1c0f21171';

abstract class _$OrderStatus extends $AsyncNotifier<OrderStatusSummary> {
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

@ProviderFor(NdrStatus)
const ndrStatusProvider = NdrStatusProvider._();

final class NdrStatusProvider
    extends $AsyncNotifierProvider<NdrStatus, NdrStatusSummary> {
  const NdrStatusProvider._()
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
  String debugGetCreateSourceHash() => _$ndrStatusHash();

  @$internal
  @override
  NdrStatus create() => NdrStatus();
}

String _$ndrStatusHash() => r'e085720a029e3b3d0547e324f2ab3894ccbbfff9';

abstract class _$NdrStatus extends $AsyncNotifier<NdrStatusSummary> {
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

@ProviderFor(CourierPickup)
const courierPickupProvider = CourierPickupProvider._();

final class CourierPickupProvider
    extends $AsyncNotifierProvider<CourierPickup, CarrierPickupSummaryList> {
  const CourierPickupProvider._()
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
  String debugGetCreateSourceHash() => _$courierPickupHash();

  @$internal
  @override
  CourierPickup create() => CourierPickup();
}

String _$courierPickupHash() => r'1255648d4daf8818eb0ef829a8ac3d0a023287b3';

abstract class _$CourierPickup
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
    extends $AsyncNotifierProvider<NdrData, nd.NdrData> {
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

String _$ndrDataHash() => r'94ded436cf998cb3036b9f4df890f130945df432';

abstract class _$NdrData extends $AsyncNotifier<nd.NdrData> {
  FutureOr<nd.NdrData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<nd.NdrData>, nd.NdrData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<nd.NdrData>, nd.NdrData>,
              AsyncValue<nd.NdrData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DatewiseNdr)
const datewiseNdrProvider = DatewiseNdrProvider._();

final class DatewiseNdrProvider
    extends $AsyncNotifierProvider<DatewiseNdr, List<DatewiseNdrCount>> {
  const DatewiseNdrProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'datewiseNdrProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$datewiseNdrHash();

  @$internal
  @override
  DatewiseNdr create() => DatewiseNdr();
}

String _$datewiseNdrHash() => r'd0715761b3e816d5e16376505ce41c905d097a17';

abstract class _$DatewiseNdr extends $AsyncNotifier<List<DatewiseNdrCount>> {
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

@ProviderFor(TopRtoData)
const topRtoDataProvider = TopRtoDataProvider._();

final class TopRtoDataProvider
    extends $AsyncNotifierProvider<TopRtoData, rto.TopRtoData> {
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

String _$topRtoDataHash() => r'285f70b830d603fab2f48f5c331a270184d8c77f';

abstract class _$TopRtoData extends $AsyncNotifier<rto.TopRtoData> {
  FutureOr<rto.TopRtoData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<rto.TopRtoData>, rto.TopRtoData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<rto.TopRtoData>, rto.TopRtoData>,
              AsyncValue<rto.TopRtoData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DatewiseRto)
const datewiseRtoProvider = DatewiseRtoProvider._();

final class DatewiseRtoProvider
    extends $AsyncNotifierProvider<DatewiseRto, List<DatewiseRtoCount>> {
  const DatewiseRtoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'datewiseRtoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$datewiseRtoHash();

  @$internal
  @override
  DatewiseRto create() => DatewiseRto();
}

String _$datewiseRtoHash() => r'115b373cc040bd2ca0c73b4640f11d885c3ff132';

abstract class _$DatewiseRto extends $AsyncNotifier<List<DatewiseRtoCount>> {
  FutureOr<List<DatewiseRtoCount>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<DatewiseRtoCount>>, List<DatewiseRtoCount>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DatewiseRtoCount>>,
                List<DatewiseRtoCount>
              >,
              AsyncValue<List<DatewiseRtoCount>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TopDeliveredData)
const topDeliveredDataProvider = TopDeliveredDataProvider._();

final class TopDeliveredDataProvider
    extends $AsyncNotifierProvider<TopDeliveredData, td.TopDeliveredData> {
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

String _$topDeliveredDataHash() => r'5b3bc3091b41b98e3bd81e76ded7690626c5b2b8';

abstract class _$TopDeliveredData extends $AsyncNotifier<td.TopDeliveredData> {
  FutureOr<td.TopDeliveredData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<td.TopDeliveredData>, td.TopDeliveredData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<td.TopDeliveredData>, td.TopDeliveredData>,
              AsyncValue<td.TopDeliveredData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CodTrend)
const codTrendProvider = CodTrendProvider._();

final class CodTrendProvider
    extends $AsyncNotifierProvider<CodTrend, List<c.CodData>> {
  const CodTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'codTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$codTrendHash();

  @$internal
  @override
  CodTrend create() => CodTrend();
}

String _$codTrendHash() => r'b83d27937e78b7d1b056e3566e24e1a2bbbf9c2d';

abstract class _$CodTrend extends $AsyncNotifier<List<c.CodData>> {
  FutureOr<List<c.CodData>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<c.CodData>>, List<c.CodData>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<c.CodData>>, List<c.CodData>>,
              AsyncValue<List<c.CodData>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(OrderRevenue)
const orderRevenueProvider = OrderRevenueProvider._();

final class OrderRevenueProvider
    extends $AsyncNotifierProvider<OrderRevenue, rev.OrderRevenue> {
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

String _$orderRevenueHash() => r'72209c00ce5c448810338ed60a7442fb9df1ef56';

abstract class _$OrderRevenue extends $AsyncNotifier<rev.OrderRevenue> {
  FutureOr<rev.OrderRevenue> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<rev.OrderRevenue>, rev.OrderRevenue>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<rev.OrderRevenue>, rev.OrderRevenue>,
              AsyncValue<rev.OrderRevenue>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(RemittanceOverview)
const remittanceOverviewProvider = RemittanceOverviewProvider._();

final class RemittanceOverviewProvider
    extends $AsyncNotifierProvider<RemittanceOverview, rem.RemittanceOverview> {
  const RemittanceOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remittanceOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remittanceOverviewHash();

  @$internal
  @override
  RemittanceOverview create() => RemittanceOverview();
}

String _$remittanceOverviewHash() =>
    r'9f66f5014e220603fa48919137f1367f16b5aa26';

abstract class _$RemittanceOverview
    extends $AsyncNotifier<rem.RemittanceOverview> {
  FutureOr<rem.RemittanceOverview> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<rem.RemittanceOverview>, rem.RemittanceOverview>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<rem.RemittanceOverview>,
                rem.RemittanceOverview
              >,
              AsyncValue<rem.RemittanceOverview>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(BusinessOverview)
const businessOverviewProvider = BusinessOverviewProvider._();

final class BusinessOverviewProvider
    extends
        $AsyncNotifierProvider<
          BusinessOverview,
          List<be.BusinessOverviewCount>
        > {
  const BusinessOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'businessOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$businessOverviewHash();

  @$internal
  @override
  BusinessOverview create() => BusinessOverview();
}

String _$businessOverviewHash() => r'7805e10cb1384905604d061a6ccdf181cd62adee';

abstract class _$BusinessOverview
    extends $AsyncNotifier<List<be.BusinessOverviewCount>> {
  FutureOr<List<be.BusinessOverviewCount>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<be.BusinessOverviewCount>>,
              List<be.BusinessOverviewCount>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<be.BusinessOverviewCount>>,
                List<be.BusinessOverviewCount>
              >,
              AsyncValue<List<be.BusinessOverviewCount>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MapOrders)
const mapOrdersProvider = MapOrdersProvider._();

final class MapOrdersProvider
    extends $AsyncNotifierProvider<MapOrders, List<be.StateStatusCount>> {
  const MapOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapOrdersHash();

  @$internal
  @override
  MapOrders create() => MapOrders();
}

String _$mapOrdersHash() => r'aef1b4e489b548238bdb85c437009cf5cc3c8402';

abstract class _$MapOrders extends $AsyncNotifier<List<be.StateStatusCount>> {
  FutureOr<List<be.StateStatusCount>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<be.StateStatusCount>>,
              List<be.StateStatusCount>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<be.StateStatusCount>>,
                List<be.StateStatusCount>
              >,
              AsyncValue<List<be.StateStatusCount>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ZoneDistribution)
const zoneDistributionProvider = ZoneDistributionProvider._();

final class ZoneDistributionProvider
    extends
        $AsyncNotifierProvider<ZoneDistribution, List<be.ZonePercentageCount>> {
  const ZoneDistributionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'zoneDistributionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$zoneDistributionHash();

  @$internal
  @override
  ZoneDistribution create() => ZoneDistribution();
}

String _$zoneDistributionHash() => r'f103770a6ba48c50b6c26e24863e03c105e08aaf';

abstract class _$ZoneDistribution
    extends $AsyncNotifier<List<be.ZonePercentageCount>> {
  FutureOr<List<be.ZonePercentageCount>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<be.ZonePercentageCount>>,
              List<be.ZonePercentageCount>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<be.ZonePercentageCount>>,
                List<be.ZonePercentageCount>
              >,
              AsyncValue<List<be.ZonePercentageCount>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
