// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_balance_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserBalanceNotifier)
const userBalanceProvider = UserBalanceNotifierProvider._();

final class UserBalanceNotifierProvider
    extends $NotifierProvider<UserBalanceNotifier, AsyncValue<UserBalance?>> {
  const UserBalanceNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userBalanceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userBalanceNotifierHash();

  @$internal
  @override
  UserBalanceNotifier create() => UserBalanceNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<UserBalance?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<UserBalance?>>(value),
    );
  }
}

String _$userBalanceNotifierHash() =>
    r'aa76c09f5632e15c519db42cdd5674ff4c5b61b8';

abstract class _$UserBalanceNotifier
    extends $Notifier<AsyncValue<UserBalance?>> {
  AsyncValue<UserBalance?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<UserBalance?>, AsyncValue<UserBalance?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserBalance?>, AsyncValue<UserBalance?>>,
              AsyncValue<UserBalance?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
