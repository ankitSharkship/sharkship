// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_rs_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedRsNotifier)
const selectedRsProvider = SelectedRsNotifierProvider._();

final class SelectedRsNotifierProvider
    extends $NotifierProvider<SelectedRsNotifier, SelectedRssState> {
  const SelectedRsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedRsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedRsNotifierHash();

  @$internal
  @override
  SelectedRsNotifier create() => SelectedRsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectedRssState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectedRssState>(value),
    );
  }
}

String _$selectedRsNotifierHash() =>
    r'129ef899266b11b0b916b33721653012feb166b2';

abstract class _$SelectedRsNotifier extends $Notifier<SelectedRssState> {
  SelectedRssState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SelectedRssState, SelectedRssState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectedRssState, SelectedRssState>,
              SelectedRssState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
