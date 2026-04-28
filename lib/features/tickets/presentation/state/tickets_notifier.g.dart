// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TicketsNotifier)
const ticketsProvider = TicketsNotifierFamily._();

final class TicketsNotifierProvider
    extends $AsyncNotifierProvider<TicketsNotifier, TicketsState> {
  const TicketsNotifierProvider._({
    required TicketsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'ticketsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ticketsNotifierHash();

  @override
  String toString() {
    return r'ticketsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TicketsNotifier create() => TicketsNotifier();

  @override
  bool operator ==(Object other) {
    return other is TicketsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ticketsNotifierHash() => r'7118834097e3e6768f21a6ae9d9d74317fbba571';

final class TicketsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TicketsNotifier,
          AsyncValue<TicketsState>,
          TicketsState,
          FutureOr<TicketsState>,
          int
        > {
  const TicketsNotifierFamily._()
    : super(
        retry: null,
        name: r'ticketsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TicketsNotifierProvider call(int tabIndex) =>
      TicketsNotifierProvider._(argument: tabIndex, from: this);

  @override
  String toString() => r'ticketsProvider';
}

abstract class _$TicketsNotifier extends $AsyncNotifier<TicketsState> {
  late final _$args = ref.$arg as int;
  int get tabIndex => _$args;

  FutureOr<TicketsState> build(int tabIndex);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<TicketsState>, TicketsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TicketsState>, TicketsState>,
              AsyncValue<TicketsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
