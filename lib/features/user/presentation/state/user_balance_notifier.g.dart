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
    extends $AsyncNotifierProvider<UserBalanceNotifier, UserBalance?> {
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
}

String _$userBalanceNotifierHash() =>
    r'6a04a73decbf2d8b32f182ccf8024a249485a912';

abstract class _$UserBalanceNotifier extends $AsyncNotifier<UserBalance?> {
  FutureOr<UserBalance?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserBalance?>, UserBalance?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserBalance?>, UserBalance?>,
              AsyncValue<UserBalance?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
