// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_logo_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileLogoNotifier)
const profileLogoProvider = ProfileLogoNotifierProvider._();

final class ProfileLogoNotifierProvider
    extends $NotifierProvider<ProfileLogoNotifier, AsyncValue<void>> {
  const ProfileLogoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileLogoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileLogoNotifierHash();

  @$internal
  @override
  ProfileLogoNotifier create() => ProfileLogoNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$profileLogoNotifierHash() =>
    r'236fc80070f3abce9e1acef89314d1f22ea431bd';

abstract class _$ProfileLogoNotifier extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
