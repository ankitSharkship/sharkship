// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courier_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CourierSettingsNotifier)
const courierSettingsProvider = CourierSettingsNotifierProvider._();

final class CourierSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<CourierSettingsNotifier, CourierSettingsState> {
  const CourierSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courierSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courierSettingsNotifierHash();

  @$internal
  @override
  CourierSettingsNotifier create() => CourierSettingsNotifier();
}

String _$courierSettingsNotifierHash() =>
    r'd9f06570c473eebe93f9a785f6164c86bd4988f7';

abstract class _$CourierSettingsNotifier
    extends $AsyncNotifier<CourierSettingsState> {
  FutureOr<CourierSettingsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<CourierSettingsState>, CourierSettingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CourierSettingsState>,
                CourierSettingsState
              >,
              AsyncValue<CourierSettingsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
