// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupons_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CouponsNotifier)
const couponsProvider = CouponsNotifierProvider._();

final class CouponsNotifierProvider
    extends $AsyncNotifierProvider<CouponsNotifier, List<CouponEntity>> {
  const CouponsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'couponsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$couponsNotifierHash();

  @$internal
  @override
  CouponsNotifier create() => CouponsNotifier();
}

String _$couponsNotifierHash() => r'3feffbe90ddd90429ae37f7fecb7391416d45bd8';

abstract class _$CouponsNotifier extends $AsyncNotifier<List<CouponEntity>> {
  FutureOr<List<CouponEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<CouponEntity>>, List<CouponEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CouponEntity>>, List<CouponEntity>>,
              AsyncValue<List<CouponEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
