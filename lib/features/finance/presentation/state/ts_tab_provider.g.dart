// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ts_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TsTab)
const tsTabProvider = TsTabProvider._();

final class TsTabProvider extends $NotifierProvider<TsTab, int> {
  const TsTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tsTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tsTabHash();

  @$internal
  @override
  TsTab create() => TsTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$tsTabHash() => r'b7a7e25e702f83c6a59358fb686b21b2fa67222f';

abstract class _$TsTab extends $Notifier<int> {
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
