// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Transactions)
const transactionsProvider = TransactionsFamily._();

final class TransactionsProvider
    extends $AsyncNotifierProvider<Transactions, TransactionsState> {
  const TransactionsProvider._({
    required TransactionsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'transactionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionsHash();

  @override
  String toString() {
    return r'transactionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Transactions create() => Transactions();

  @override
  bool operator ==(Object other) {
    return other is TransactionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionsHash() => r'd6aaf978164c61e9a8b5bbe02f9723ae6b010b7e';

final class TransactionsFamily extends $Family
    with
        $ClassFamilyOverride<
          Transactions,
          AsyncValue<TransactionsState>,
          TransactionsState,
          FutureOr<TransactionsState>,
          int
        > {
  const TransactionsFamily._()
    : super(
        retry: null,
        name: r'transactionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TransactionsProvider call(int tabIndex) =>
      TransactionsProvider._(argument: tabIndex, from: this);

  @override
  String toString() => r'transactionsProvider';
}

abstract class _$Transactions extends $AsyncNotifier<TransactionsState> {
  late final _$args = ref.$arg as int;
  int get tabIndex => _$args;

  FutureOr<TransactionsState> build(int tabIndex);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<TransactionsState>, TransactionsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TransactionsState>, TransactionsState>,
              AsyncValue<TransactionsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
