// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ndr_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NdrNotifier)
const ndrProvider = NdrNotifierFamily._();

final class NdrNotifierProvider
    extends $AsyncNotifierProvider<NdrNotifier, NdrState> {
  const NdrNotifierProvider._({
    required NdrNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'ndrProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ndrNotifierHash();

  @override
  String toString() {
    return r'ndrProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NdrNotifier create() => NdrNotifier();

  @override
  bool operator ==(Object other) {
    return other is NdrNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ndrNotifierHash() => r'bb3b227cca773fe9d68eb7f175975ac6368575a2';

final class NdrNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          NdrNotifier,
          AsyncValue<NdrState>,
          NdrState,
          FutureOr<NdrState>,
          int
        > {
  const NdrNotifierFamily._()
    : super(
        retry: null,
        name: r'ndrProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NdrNotifierProvider call(int tabIndex) =>
      NdrNotifierProvider._(argument: tabIndex, from: this);

  @override
  String toString() => r'ndrProvider';
}

abstract class _$NdrNotifier extends $AsyncNotifier<NdrState> {
  late final _$args = ref.$arg as int;
  int get tabIndex => _$args;

  FutureOr<NdrState> build(int tabIndex);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<NdrState>, NdrState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NdrState>, NdrState>,
              AsyncValue<NdrState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
