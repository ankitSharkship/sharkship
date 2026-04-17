// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sc_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScTab)
const scTabProvider = ScTabProvider._();

final class ScTabProvider extends $NotifierProvider<ScTab, int> {
  const ScTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scTabHash();

  @$internal
  @override
  ScTab create() => ScTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$scTabHash() => r'050b14730356db92a16c545f266fd84017cee42b';

abstract class _$ScTab extends $Notifier<int> {
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
