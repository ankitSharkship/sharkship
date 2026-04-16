// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrackingNotifier)
const trackingProvider = TrackingNotifierProvider._();

final class TrackingNotifierProvider
    extends $AsyncNotifierProvider<TrackingNotifier, TrackingDetailsEntity?> {
  const TrackingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackingNotifierHash();

  @$internal
  @override
  TrackingNotifier create() => TrackingNotifier();
}

String _$trackingNotifierHash() => r'1edcd8d4b109d85c696064c50072dbbf30a4de89';

abstract class _$TrackingNotifier
    extends $AsyncNotifier<TrackingDetailsEntity?> {
  FutureOr<TrackingDetailsEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<TrackingDetailsEntity?>, TrackingDetailsEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TrackingDetailsEntity?>,
                TrackingDetailsEntity?
              >,
              AsyncValue<TrackingDetailsEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
