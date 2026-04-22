// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_ts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedTsNotifier)
const selectedTsProvider = SelectedTsNotifierFamily._();

final class SelectedTsNotifierProvider
    extends $NotifierProvider<SelectedTsNotifier, SelectedTssState> {
  const SelectedTsNotifierProvider._({
    required SelectedTsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'selectedTsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedTsNotifierHash();

  @override
  String toString() {
    return r'selectedTsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedTsNotifier create() => SelectedTsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectedTssState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectedTssState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedTsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedTsNotifierHash() =>
    r'cf605a01497ae781f975bb819bcc498ae80d506d';

final class SelectedTsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SelectedTsNotifier,
          SelectedTssState,
          SelectedTssState,
          SelectedTssState,
          int
        > {
  const SelectedTsNotifierFamily._()
    : super(
        retry: null,
        name: r'selectedTsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedTsNotifierProvider call(int index) =>
      SelectedTsNotifierProvider._(argument: index, from: this);

  @override
  String toString() => r'selectedTsProvider';
}

abstract class _$SelectedTsNotifier extends $Notifier<SelectedTssState> {
  late final _$args = ref.$arg as int;
  int get index => _$args;

  SelectedTssState build(int index);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<SelectedTssState, SelectedTssState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectedTssState, SelectedTssState>,
              SelectedTssState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
