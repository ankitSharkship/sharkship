// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignupNotifier)
const signupProvider = SignupNotifierProvider._();

final class SignupNotifierProvider
    extends $NotifierProvider<SignupNotifier, SignupState> {
  const SignupNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signupNotifierHash();

  @$internal
  @override
  SignupNotifier create() => SignupNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignupState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignupState>(value),
    );
  }
}

String _$signupNotifierHash() => r'fc4dbda069735728cb4e39e32d63d789da2b2ee8';

abstract class _$SignupNotifier extends $Notifier<SignupState> {
  SignupState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SignupState, SignupState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SignupState, SignupState>,
              SignupState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
