// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retail_api_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RetailApiNotifier)
const retailApiProvider = RetailApiNotifierProvider._();

final class RetailApiNotifierProvider
    extends $AsyncNotifierProvider<RetailApiNotifier, RetailApiDetailsEntity> {
  const RetailApiNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'retailApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$retailApiNotifierHash();

  @$internal
  @override
  RetailApiNotifier create() => RetailApiNotifier();
}

String _$retailApiNotifierHash() => r'eb6f877660e05bc0ab3f2ead5aa9da29222f6582';

abstract class _$RetailApiNotifier
    extends $AsyncNotifier<RetailApiDetailsEntity> {
  FutureOr<RetailApiDetailsEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<RetailApiDetailsEntity>, RetailApiDetailsEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<RetailApiDetailsEntity>,
                RetailApiDetailsEntity
              >,
              AsyncValue<RetailApiDetailsEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
