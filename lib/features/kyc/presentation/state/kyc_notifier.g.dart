// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KycNotifier)
const kycProvider = KycNotifierProvider._();

final class KycNotifierProvider
    extends $NotifierProvider<KycNotifier, KycState> {
  const KycNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kycProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kycNotifierHash();

  @$internal
  @override
  KycNotifier create() => KycNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KycState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KycState>(value),
    );
  }
}

String _$kycNotifierHash() => r'd1506c7b3a3c31989e40c710e0d58a72be82286e';

abstract class _$KycNotifier extends $Notifier<KycState> {
  KycState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<KycState, KycState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<KycState, KycState>,
              KycState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
