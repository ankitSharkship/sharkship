// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dashboardRemoteDataSource)
const dashboardRemoteDataSourceProvider = DashboardRemoteDataSourceProvider._();

final class DashboardRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          DashboardRemoteDataSource,
          DashboardRemoteDataSource,
          DashboardRemoteDataSource
        >
    with $Provider<DashboardRemoteDataSource> {
  const DashboardRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<DashboardRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DashboardRemoteDataSource create(Ref ref) {
    return dashboardRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardRemoteDataSource>(value),
    );
  }
}

String _$dashboardRemoteDataSourceHash() =>
    r'afea76be85e5b14f6b355913e477e6af116259a3';

@ProviderFor(dashboardRepository)
const dashboardRepositoryProvider = DashboardRepositoryProvider._();

final class DashboardRepositoryProvider
    extends
        $FunctionalProvider<
          DashboardRepository,
          DashboardRepository,
          DashboardRepository
        >
    with $Provider<DashboardRepository> {
  const DashboardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRepositoryHash();

  @$internal
  @override
  $ProviderElement<DashboardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DashboardRepository create(Ref ref) {
    return dashboardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardRepository>(value),
    );
  }
}

String _$dashboardRepositoryHash() =>
    r'a152282720befde7ff91e3ec21d0a50c21c44ff6';

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

String _$dashboardDateHash() => r'48aa338494f2772b7f5d58b838182a68f83f69f5';

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

@ProviderFor(getTodayMetricsUseCase)
const getTodayMetricsUseCaseProvider = GetTodayMetricsUseCaseProvider._();

final class GetTodayMetricsUseCaseProvider
    extends
        $FunctionalProvider<
          GetTodayMetricsUseCase,
          GetTodayMetricsUseCase,
          GetTodayMetricsUseCase
        >
    with $Provider<GetTodayMetricsUseCase> {
  const GetTodayMetricsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTodayMetricsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTodayMetricsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTodayMetricsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTodayMetricsUseCase create(Ref ref) {
    return getTodayMetricsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTodayMetricsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTodayMetricsUseCase>(value),
    );
  }
}

String _$getTodayMetricsUseCaseHash() =>
    r'a4fb2d81e8b658811189f9e7a80202b5ac0af6c8';

@ProviderFor(getOrderStatusCountUseCase)
const getOrderStatusCountUseCaseProvider =
    GetOrderStatusCountUseCaseProvider._();

final class GetOrderStatusCountUseCaseProvider
    extends
        $FunctionalProvider<
          GetOrderStatusCountUseCase,
          GetOrderStatusCountUseCase,
          GetOrderStatusCountUseCase
        >
    with $Provider<GetOrderStatusCountUseCase> {
  const GetOrderStatusCountUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getOrderStatusCountUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getOrderStatusCountUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetOrderStatusCountUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetOrderStatusCountUseCase create(Ref ref) {
    return getOrderStatusCountUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetOrderStatusCountUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetOrderStatusCountUseCase>(value),
    );
  }
}

String _$getOrderStatusCountUseCaseHash() =>
    r'99c870571f6a6244de131c032891c8d956c5e6e8';

@ProviderFor(getNdrStatusCountUseCase)
const getNdrStatusCountUseCaseProvider = GetNdrStatusCountUseCaseProvider._();

final class GetNdrStatusCountUseCaseProvider
    extends
        $FunctionalProvider<
          GetNdrStatusCountUsecase,
          GetNdrStatusCountUsecase,
          GetNdrStatusCountUsecase
        >
    with $Provider<GetNdrStatusCountUsecase> {
  const GetNdrStatusCountUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNdrStatusCountUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNdrStatusCountUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetNdrStatusCountUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetNdrStatusCountUsecase create(Ref ref) {
    return getNdrStatusCountUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetNdrStatusCountUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetNdrStatusCountUsecase>(value),
    );
  }
}

String _$getNdrStatusCountUseCaseHash() =>
    r'f0319767084df02e59f95ffc2deb44aaac93d3c0';

@ProviderFor(getCarrierPickupDataUsecase)
const getCarrierPickupDataUsecaseProvider =
    GetCarrierPickupDataUsecaseProvider._();

final class GetCarrierPickupDataUsecaseProvider
    extends
        $FunctionalProvider<
          GetCarrierPickupDataUsecase,
          GetCarrierPickupDataUsecase,
          GetCarrierPickupDataUsecase
        >
    with $Provider<GetCarrierPickupDataUsecase> {
  const GetCarrierPickupDataUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCarrierPickupDataUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCarrierPickupDataUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetCarrierPickupDataUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCarrierPickupDataUsecase create(Ref ref) {
    return getCarrierPickupDataUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCarrierPickupDataUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCarrierPickupDataUsecase>(value),
    );
  }
}

String _$getCarrierPickupDataUsecaseHash() =>
    r'79cb0c0e76c77a548244ec3c76b7ca5b2e44ceb0';

@ProviderFor(getNdrDataUseCase)
const getNdrDataUseCaseProvider = GetNdrDataUseCaseProvider._();

final class GetNdrDataUseCaseProvider
    extends
        $FunctionalProvider<
          GetNdrDataUseCase,
          GetNdrDataUseCase,
          GetNdrDataUseCase
        >
    with $Provider<GetNdrDataUseCase> {
  const GetNdrDataUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNdrDataUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNdrDataUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetNdrDataUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetNdrDataUseCase create(Ref ref) {
    return getNdrDataUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetNdrDataUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetNdrDataUseCase>(value),
    );
  }
}

String _$getNdrDataUseCaseHash() => r'ec7d617c93ccb8eeea0113f4aab2a0d71a54a8e4';

@ProviderFor(getDatewiseNdrCountUseCase)
const getDatewiseNdrCountUseCaseProvider =
    GetDatewiseNdrCountUseCaseProvider._();

final class GetDatewiseNdrCountUseCaseProvider
    extends
        $FunctionalProvider<
          GetDatewiseNdrCountUseCase,
          GetDatewiseNdrCountUseCase,
          GetDatewiseNdrCountUseCase
        >
    with $Provider<GetDatewiseNdrCountUseCase> {
  const GetDatewiseNdrCountUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDatewiseNdrCountUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDatewiseNdrCountUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetDatewiseNdrCountUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetDatewiseNdrCountUseCase create(Ref ref) {
    return getDatewiseNdrCountUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetDatewiseNdrCountUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetDatewiseNdrCountUseCase>(value),
    );
  }
}

String _$getDatewiseNdrCountUseCaseHash() =>
    r'15add331884aa1e0898fb31b4c4a0ece7c3fd7d1';

@ProviderFor(getTopRtoDataUseCase)
const getTopRtoDataUseCaseProvider = GetTopRtoDataUseCaseProvider._();

final class GetTopRtoDataUseCaseProvider
    extends
        $FunctionalProvider<
          GetTopRtoDataUseCase,
          GetTopRtoDataUseCase,
          GetTopRtoDataUseCase
        >
    with $Provider<GetTopRtoDataUseCase> {
  const GetTopRtoDataUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTopRtoDataUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTopRtoDataUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTopRtoDataUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTopRtoDataUseCase create(Ref ref) {
    return getTopRtoDataUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTopRtoDataUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTopRtoDataUseCase>(value),
    );
  }
}

String _$getTopRtoDataUseCaseHash() =>
    r'd0fcedf1564eb62e3b0b7b04beabda55eead79e7';

@ProviderFor(getDatewiseRtoCountUseCase)
const getDatewiseRtoCountUseCaseProvider =
    GetDatewiseRtoCountUseCaseProvider._();

final class GetDatewiseRtoCountUseCaseProvider
    extends
        $FunctionalProvider<
          GetDatewiseRtoCountUseCase,
          GetDatewiseRtoCountUseCase,
          GetDatewiseRtoCountUseCase
        >
    with $Provider<GetDatewiseRtoCountUseCase> {
  const GetDatewiseRtoCountUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDatewiseRtoCountUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDatewiseRtoCountUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetDatewiseRtoCountUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetDatewiseRtoCountUseCase create(Ref ref) {
    return getDatewiseRtoCountUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetDatewiseRtoCountUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetDatewiseRtoCountUseCase>(value),
    );
  }
}

String _$getDatewiseRtoCountUseCaseHash() =>
    r'4138a90de93d2369d739fc19247562b7574280fc';

@ProviderFor(getTopDeliveredDataUseCase)
const getTopDeliveredDataUseCaseProvider =
    GetTopDeliveredDataUseCaseProvider._();

final class GetTopDeliveredDataUseCaseProvider
    extends
        $FunctionalProvider<
          GetTopDeliveredDataUseCase,
          GetTopDeliveredDataUseCase,
          GetTopDeliveredDataUseCase
        >
    with $Provider<GetTopDeliveredDataUseCase> {
  const GetTopDeliveredDataUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTopDeliveredDataUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTopDeliveredDataUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTopDeliveredDataUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTopDeliveredDataUseCase create(Ref ref) {
    return getTopDeliveredDataUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTopDeliveredDataUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTopDeliveredDataUseCase>(value),
    );
  }
}

String _$getTopDeliveredDataUseCaseHash() =>
    r'38c5f3432b8875d81477af8d565989a8c777f8b3';

@ProviderFor(getCodDataUseCase)
const getCodDataUseCaseProvider = GetCodDataUseCaseProvider._();

final class GetCodDataUseCaseProvider
    extends
        $FunctionalProvider<
          GetCodDataUseCase,
          GetCodDataUseCase,
          GetCodDataUseCase
        >
    with $Provider<GetCodDataUseCase> {
  const GetCodDataUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCodDataUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCodDataUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCodDataUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCodDataUseCase create(Ref ref) {
    return getCodDataUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCodDataUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCodDataUseCase>(value),
    );
  }
}

String _$getCodDataUseCaseHash() => r'8dfc823f29f9a531ff186f41ecbac9ce349158ed';

@ProviderFor(getOrderRevenueUseCase)
const getOrderRevenueUseCaseProvider = GetOrderRevenueUseCaseProvider._();

final class GetOrderRevenueUseCaseProvider
    extends
        $FunctionalProvider<
          GetOrderRevenueUseCase,
          GetOrderRevenueUseCase,
          GetOrderRevenueUseCase
        >
    with $Provider<GetOrderRevenueUseCase> {
  const GetOrderRevenueUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getOrderRevenueUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getOrderRevenueUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetOrderRevenueUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetOrderRevenueUseCase create(Ref ref) {
    return getOrderRevenueUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetOrderRevenueUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetOrderRevenueUseCase>(value),
    );
  }
}

String _$getOrderRevenueUseCaseHash() =>
    r'6a82673004fac858081a6ee40f40fe07100c539c';
