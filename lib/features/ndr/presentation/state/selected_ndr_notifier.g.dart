// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_ndr_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedNdrNotifier)
const selectedNdrProvider = SelectedNdrNotifierFamily._();

final class SelectedNdrNotifierProvider
    extends $NotifierProvider<SelectedNdrNotifier, SelectedNdrsState> {
  const SelectedNdrNotifierProvider._({
    required SelectedNdrNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'selectedNdrProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedNdrNotifierHash();

  @override
  String toString() {
    return r'selectedNdrProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedNdrNotifier create() => SelectedNdrNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectedNdrsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectedNdrsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedNdrNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedNdrNotifierHash() =>
    r'9bc206d6841718811a1be688d5bae98e12885a4b';

final class SelectedNdrNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SelectedNdrNotifier,
          SelectedNdrsState,
          SelectedNdrsState,
          SelectedNdrsState,
          int
        > {
  const SelectedNdrNotifierFamily._()
    : super(
        retry: null,
        name: r'selectedNdrProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedNdrNotifierProvider call(int index) =>
      SelectedNdrNotifierProvider._(argument: index, from: this);

  @override
  String toString() => r'selectedNdrProvider';
}

abstract class _$SelectedNdrNotifier extends $Notifier<SelectedNdrsState> {
  late final _$args = ref.$arg as int;
  int get index => _$args;

  SelectedNdrsState build(int index);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<SelectedNdrsState, SelectedNdrsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectedNdrsState, SelectedNdrsState>,
              SelectedNdrsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
