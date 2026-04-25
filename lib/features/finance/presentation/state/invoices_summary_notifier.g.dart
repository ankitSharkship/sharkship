// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_summary_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaxInvoices)
const taxInvoicesProvider = TaxInvoicesFamily._();

final class TaxInvoicesProvider
    extends $AsyncNotifierProvider<TaxInvoices, IsState> {
  const TaxInvoicesProvider._({
    required TaxInvoicesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'taxInvoicesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taxInvoicesHash();

  @override
  String toString() {
    return r'taxInvoicesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TaxInvoices create() => TaxInvoices();

  @override
  bool operator ==(Object other) {
    return other is TaxInvoicesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taxInvoicesHash() => r'41e176ac6766d0193875c87af15527cd4b1b4bdd';

final class TaxInvoicesFamily extends $Family
    with
        $ClassFamilyOverride<
          TaxInvoices,
          AsyncValue<IsState>,
          IsState,
          FutureOr<IsState>,
          int
        > {
  const TaxInvoicesFamily._()
    : super(
        retry: null,
        name: r'taxInvoicesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TaxInvoicesProvider call(int tabIndex) =>
      TaxInvoicesProvider._(argument: tabIndex, from: this);

  @override
  String toString() => r'taxInvoicesProvider';
}

abstract class _$TaxInvoices extends $AsyncNotifier<IsState> {
  late final _$args = ref.$arg as int;
  int get tabIndex => _$args;

  FutureOr<IsState> build(int tabIndex);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<IsState>, IsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<IsState>, IsState>,
              AsyncValue<IsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
