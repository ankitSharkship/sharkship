// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wd_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WdTab)
const wdTabProvider = WdTabProvider._();

final class WdTabProvider extends $NotifierProvider<WdTab, int> {
  const WdTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wdTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wdTabHash();

  @$internal
  @override
  WdTab create() => WdTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$wdTabHash() => r'efe8ecf6550f2f52f18e453dd7e38a65a1ba2abc';

abstract class _$WdTab extends $Notifier<int> {
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
