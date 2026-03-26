// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardTab)
const dashboardTabProvider = DashboardTabProvider._();

final class DashboardTabProvider extends $NotifierProvider<DashboardTab, int> {
  const DashboardTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardTabHash();

  @$internal
  @override
  DashboardTab create() => DashboardTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$dashboardTabHash() => r'80e6d3bc67df9d97993a528b6fecec13f5415e63';

abstract class _$DashboardTab extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
