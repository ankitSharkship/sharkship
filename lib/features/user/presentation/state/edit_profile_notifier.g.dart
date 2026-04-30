// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EditProfileNotifier)
const editProfileProvider = EditProfileNotifierProvider._();

final class EditProfileNotifierProvider
    extends $NotifierProvider<EditProfileNotifier, EditProfileState> {
  const EditProfileNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editProfileNotifierHash();

  @$internal
  @override
  EditProfileNotifier create() => EditProfileNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditProfileState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditProfileState>(value),
    );
  }
}

String _$editProfileNotifierHash() =>
    r'f227ed7c7c140a02dadd47d88f59dd16f47b2695';

abstract class _$EditProfileNotifier extends $Notifier<EditProfileState> {
  EditProfileState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EditProfileState, EditProfileState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EditProfileState, EditProfileState>,
              EditProfileState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
