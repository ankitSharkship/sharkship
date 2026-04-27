// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportsNotifier)
const reportsProvider = ReportsNotifierProvider._();

final class ReportsNotifierProvider
    extends $AsyncNotifierProvider<ReportsNotifier, ReportsState> {
  const ReportsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsNotifierHash();

  @$internal
  @override
  ReportsNotifier create() => ReportsNotifier();
}

String _$reportsNotifierHash() => r'ad782c0c701e21b8ef182cc08c63662f4c26c8de';

abstract class _$ReportsNotifier extends $AsyncNotifier<ReportsState> {
  FutureOr<ReportsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ReportsState>, ReportsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReportsState>, ReportsState>,
              AsyncValue<ReportsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
