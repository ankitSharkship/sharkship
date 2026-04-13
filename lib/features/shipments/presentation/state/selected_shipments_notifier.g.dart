// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_shipments_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedShipmentsNotifier)
const selectedShipmentsProvider = SelectedShipmentsNotifierFamily._();

final class SelectedShipmentsNotifierProvider
    extends
        $NotifierProvider<SelectedShipmentsNotifier, SelectedShipmentsState> {
  const SelectedShipmentsNotifierProvider._({
    required SelectedShipmentsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'selectedShipmentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$selectedShipmentsNotifierHash();

  @override
  String toString() {
    return r'selectedShipmentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SelectedShipmentsNotifier create() => SelectedShipmentsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectedShipmentsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectedShipmentsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedShipmentsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$selectedShipmentsNotifierHash() =>
    r'cd4523ec91258e1458471272dac6ea87c49c3cae';

final class SelectedShipmentsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SelectedShipmentsNotifier,
          SelectedShipmentsState,
          SelectedShipmentsState,
          SelectedShipmentsState,
          int
        > {
  const SelectedShipmentsNotifierFamily._()
    : super(
        retry: null,
        name: r'selectedShipmentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SelectedShipmentsNotifierProvider call(int index) =>
      SelectedShipmentsNotifierProvider._(argument: index, from: this);

  @override
  String toString() => r'selectedShipmentsProvider';
}

abstract class _$SelectedShipmentsNotifier
    extends $Notifier<SelectedShipmentsState> {
  late final _$args = ref.$arg as int;
  int get index => _$args;

  SelectedShipmentsState build(int index);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<SelectedShipmentsState, SelectedShipmentsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectedShipmentsState, SelectedShipmentsState>,
              SelectedShipmentsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
