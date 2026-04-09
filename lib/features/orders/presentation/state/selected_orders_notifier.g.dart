// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_orders_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedOrdersNotifier)
const selectedOrdersProvider = SelectedOrdersNotifierFamily._();

final class SelectedOrdersNotifierProvider
    extends $NotifierProvider<SelectedOrdersNotifier, SelectedOrdersState> {
  const SelectedOrdersNotifierProvider._({
    required SelectedOrdersNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'selectedOrdersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedOrdersNotifierHash();

  @override
  String toString() {
    return r'selectedOrdersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedOrdersNotifier create() => SelectedOrdersNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectedOrdersState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectedOrdersState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedOrdersNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedOrdersNotifierHash() =>
    r'f704cfe18e847e555cab61ad06cc5b51cacef7da';

final class SelectedOrdersNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SelectedOrdersNotifier,
          SelectedOrdersState,
          SelectedOrdersState,
          SelectedOrdersState,
          int
        > {
  const SelectedOrdersNotifierFamily._()
    : super(
        retry: null,
        name: r'selectedOrdersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedOrdersNotifierProvider call(int tabIndex) =>
      SelectedOrdersNotifierProvider._(argument: tabIndex, from: this);

  @override
  String toString() => r'selectedOrdersProvider';
}

abstract class _$SelectedOrdersNotifier extends $Notifier<SelectedOrdersState> {
  late final _$args = ref.$arg as int;
  int get tabIndex => _$args;

  SelectedOrdersState build(int tabIndex);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<SelectedOrdersState, SelectedOrdersState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectedOrdersState, SelectedOrdersState>,
              SelectedOrdersState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
