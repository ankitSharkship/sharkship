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
