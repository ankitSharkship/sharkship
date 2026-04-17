// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_wd_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedWdNotifier)
const selectedWdProvider = SelectedWdNotifierFamily._();

final class SelectedWdNotifierProvider
    extends $NotifierProvider<SelectedWdNotifier, SelectedWdsState> {
  const SelectedWdNotifierProvider._({
    required SelectedWdNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'selectedWdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedWdNotifierHash();

  @override
  String toString() {
    return r'selectedWdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedWdNotifier create() => SelectedWdNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectedWdsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectedWdsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedWdNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedWdNotifierHash() =>
    r'41e1279987f153771d1fb8f3e1b4b6b2da64ab8e';

final class SelectedWdNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SelectedWdNotifier,
          SelectedWdsState,
          SelectedWdsState,
          SelectedWdsState,
          int
        > {
  const SelectedWdNotifierFamily._()
    : super(
        retry: null,
        name: r'selectedWdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedWdNotifierProvider call(int index) =>
      SelectedWdNotifierProvider._(argument: index, from: this);

  @override
  String toString() => r'selectedWdProvider';
}

abstract class _$SelectedWdNotifier extends $Notifier<SelectedWdsState> {
  late final _$args = ref.$arg as int;
  int get index => _$args;

  SelectedWdsState build(int index);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<SelectedWdsState, SelectedWdsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectedWdsState, SelectedWdsState>,
              SelectedWdsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
