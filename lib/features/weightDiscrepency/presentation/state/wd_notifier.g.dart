// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wd_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WdNotifier)
const wdProvider = WdNotifierFamily._();

final class WdNotifierProvider
    extends $AsyncNotifierProvider<WdNotifier, WdState> {
  const WdNotifierProvider._({
    required WdNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'wdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$wdNotifierHash();

  @override
  String toString() {
    return r'wdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WdNotifier create() => WdNotifier();

  @override
  bool operator ==(Object other) {
    return other is WdNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wdNotifierHash() => r'9a72b89bf508760920f9569b7d499a0932c0f342';

final class WdNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          WdNotifier,
          AsyncValue<WdState>,
          WdState,
          FutureOr<WdState>,
          int
        > {
  const WdNotifierFamily._()
    : super(
        retry: null,
        name: r'wdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WdNotifierProvider call(int tabIndex) =>
      WdNotifierProvider._(argument: tabIndex, from: this);

  @override
  String toString() => r'wdProvider';
}

abstract class _$WdNotifier extends $AsyncNotifier<WdState> {
  late final _$args = ref.$arg as int;
  int get tabIndex => _$args;

  FutureOr<WdState> build(int tabIndex);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<WdState>, WdState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WdState>, WdState>,
              AsyncValue<WdState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
