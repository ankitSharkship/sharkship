// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ndr_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NdrTab)
const ndrTabProvider = NdrTabProvider._();

final class NdrTabProvider extends $NotifierProvider<NdrTab, int> {
  const NdrTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ndrTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ndrTabHash();

  @$internal
  @override
  NdrTab create() => NdrTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$ndrTabHash() => r'd961187c0362f1e72a20ab4db946f7701e09011f';

abstract class _$NdrTab extends $Notifier<int> {
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
