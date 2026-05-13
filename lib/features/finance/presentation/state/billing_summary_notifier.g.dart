// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_summary_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BillingSummaryNotifier)
const billingSummaryProvider = BillingSummaryNotifierProvider._();

final class BillingSummaryNotifierProvider
    extends
        $AsyncNotifierProvider<BillingSummaryNotifier, BillingSummaryState> {
  const BillingSummaryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billingSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billingSummaryNotifierHash();

  @$internal
  @override
  BillingSummaryNotifier create() => BillingSummaryNotifier();
}

String _$billingSummaryNotifierHash() =>
    r'71e9aba8d278d46cee1feda68e6644147ae4abb1';

abstract class _$BillingSummaryNotifier
    extends $AsyncNotifier<BillingSummaryState> {
  FutureOr<BillingSummaryState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<BillingSummaryState>, BillingSummaryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BillingSummaryState>, BillingSummaryState>,
              AsyncValue<BillingSummaryState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
