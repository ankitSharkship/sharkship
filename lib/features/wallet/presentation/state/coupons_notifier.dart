import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/coupon_entity.dart';
import 'wallet_providers.dart';

part 'coupons_notifier.g.dart';

@riverpod
class CouponsNotifier extends _$CouponsNotifier {
  @override
  Future<List<CouponEntity>> build() async {
    final useCase = ref.watch(getCouponsUseCaseProvider);
    return await useCase();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  Future<double?> validateCoupon(String couponCode, double amount) async {
    try {
      final useCase = ref.read(validateCouponUseCaseProvider);
      final result = await useCase(couponCode, amount);
      return result.cashbackAmt;
    } catch (e) {
      return null;
    }
  }
}
