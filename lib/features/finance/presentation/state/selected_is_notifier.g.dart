// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_is_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedIsNotifier)
const selectedIsProvider = SelectedIsNotifierFamily._();

final class SelectedIsNotifierProvider
    extends $NotifierProvider<SelectedIsNotifier, SelectedIssState> {
  const SelectedIsNotifierProvider._({
    required SelectedIsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'selectedIsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedIsNotifierHash();

  @override
  String toString() {
    return r'selectedIsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedIsNotifier create() => SelectedIsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectedIssState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectedIssState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedIsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedIsNotifierHash() =>
    r'de120126dfff0ae2b16aff82219cb58a673724a2';

final class SelectedIsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SelectedIsNotifier,
          SelectedIssState,
          SelectedIssState,
          SelectedIssState,
          int
        > {
  const SelectedIsNotifierFamily._()
    : super(
        retry: null,
        name: r'selectedIsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedIsNotifierProvider call(int index) =>
      SelectedIsNotifierProvider._(argument: index, from: this);

  @override
  String toString() => r'selectedIsProvider';
}

abstract class _$SelectedIsNotifier extends $Notifier<SelectedIssState> {
  late final _$args = ref.$arg as int;
  int get index => _$args;

  SelectedIssState build(int index);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<SelectedIssState, SelectedIssState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectedIssState, SelectedIssState>,
              SelectedIssState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
