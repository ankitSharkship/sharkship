// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remittance_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Remittance)
const remittanceProvider = RemittanceProvider._();

final class RemittanceProvider
    extends $AsyncNotifierProvider<Remittance, RemittanceState> {
  const RemittanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remittanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remittanceHash();

  @$internal
  @override
  Remittance create() => Remittance();
}

String _$remittanceHash() => r'74d63f514986c1d3c0719d1a33beeec2a4a4ba27';

abstract class _$Remittance extends $AsyncNotifier<RemittanceState> {
  FutureOr<RemittanceState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<RemittanceState>, RemittanceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RemittanceState>, RemittanceState>,
              AsyncValue<RemittanceState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
