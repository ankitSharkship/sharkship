// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsTab)
const isTabProvider = IsTabProvider._();

final class IsTabProvider extends $NotifierProvider<IsTab, int> {
  const IsTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isTabHash();

  @$internal
  @override
  IsTab create() => IsTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$isTabHash() => r'34a14f0dc105122d76f50296c660d3577b692e8a';

abstract class _$IsTab extends $Notifier<int> {
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
