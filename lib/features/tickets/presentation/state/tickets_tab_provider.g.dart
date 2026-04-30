// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TicketsTab)
const ticketsTabProvider = TicketsTabProvider._();

final class TicketsTabProvider extends $NotifierProvider<TicketsTab, int> {
  const TicketsTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketsTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketsTabHash();

  @$internal
  @override
  TicketsTab create() => TicketsTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$ticketsTabHash() => r'213c9947789b6b3d8d2e26bcd55ec1c16ab05256';

abstract class _$TicketsTab extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
