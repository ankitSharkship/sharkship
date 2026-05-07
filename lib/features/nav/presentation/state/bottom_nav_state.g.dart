// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BottomNav)
const bottomNavProvider = BottomNavProvider._();

final class BottomNavProvider extends $NotifierProvider<BottomNav, int> {
  const BottomNavProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bottomNavProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bottomNavHash();

  @$internal
  @override
  BottomNav create() => BottomNav();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$bottomNavHash() => r'1d7bed45d76287bac36ac5a76ab8cfd0356174b0';

abstract class _$BottomNav extends $Notifier<int> {
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
