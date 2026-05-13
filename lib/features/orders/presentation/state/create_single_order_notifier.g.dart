// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_single_order_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateSingleOrderNotifier)
const createSingleOrderProvider = CreateSingleOrderNotifierProvider._();

final class CreateSingleOrderNotifierProvider
    extends
        $NotifierProvider<CreateSingleOrderNotifier, CreateSingleOrderState> {
  const CreateSingleOrderNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createSingleOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createSingleOrderNotifierHash();

  @$internal
  @override
  CreateSingleOrderNotifier create() => CreateSingleOrderNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateSingleOrderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateSingleOrderState>(value),
    );
  }
}

String _$createSingleOrderNotifierHash() =>
    r'9ce286f4294d768768ac87e337ac537c977c2622';

abstract class _$CreateSingleOrderNotifier
    extends $Notifier<CreateSingleOrderState> {
  CreateSingleOrderState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<CreateSingleOrderState, CreateSingleOrderState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CreateSingleOrderState, CreateSingleOrderState>,
              CreateSingleOrderState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
