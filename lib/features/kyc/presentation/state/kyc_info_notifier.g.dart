// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_info_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KycInfoNotifier)
const kycInfo = KycInfoNotifierProvider._();

final class KycInfoNotifierProvider
    extends $AsyncNotifierProvider<KycInfoNotifier, Kyc> {
  const KycInfoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kycInfo',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kycInfoNotifierHash();

  @$internal
  @override
  KycInfoNotifier create() => KycInfoNotifier();
}

String _$kycInfoNotifierHash() => r'8a875da41755a16cbd13b08f3476176851491f77';

abstract class _$KycInfoNotifier extends $AsyncNotifier<Kyc> {
  FutureOr<Kyc> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Kyc>, Kyc>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Kyc>, Kyc>,
              AsyncValue<Kyc>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
