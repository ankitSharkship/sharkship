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
    extends $AsyncNotifierProvider<KycNotifier, KycState> {
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
}

String _$kycNotifierHash() => r'819ce83ce3fb7e4ea4ee09d2051df4f5a4fc9f36';

abstract class _$KycNotifier extends $AsyncNotifier<KycState> {
  FutureOr<KycState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<KycState>, KycState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KycState>, KycState>,
              AsyncValue<KycState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
