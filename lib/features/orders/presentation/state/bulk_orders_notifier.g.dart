// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_orders_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BulkOrdersNotifier)
const bulkOrdersProvider = BulkOrdersNotifierProvider._();

final class BulkOrdersNotifierProvider
    extends $NotifierProvider<BulkOrdersNotifier, BulkOrdersState> {
  const BulkOrdersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bulkOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bulkOrdersNotifierHash();

  @$internal
  @override
  BulkOrdersNotifier create() => BulkOrdersNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BulkOrdersState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BulkOrdersState>(value),
    );
  }
}

String _$bulkOrdersNotifierHash() =>
    r'f2f46a6f9d2b8c1711ce592d12c6afa7333ba724';

abstract class _$BulkOrdersNotifier extends $Notifier<BulkOrdersState> {
  BulkOrdersState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<BulkOrdersState, BulkOrdersState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BulkOrdersState, BulkOrdersState>,
              BulkOrdersState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
