import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/features/user/presentation/state/user_providers.dart';
import 'package:sharkship/features/wallet/data/datasources/cashfree_datasource.dart';
import 'package:sharkship/features/wallet/data/datasources/payu_datasource.dart';
import 'package:sharkship/features/wallet/data/datasources/razorpay_datasource.dart';
import 'package:sharkship/features/wallet/data/repositories/payment_repository_impl.dart';
import 'package:sharkship/features/wallet/data/repositories/phonepe_reository_impl.dart';
import 'package:sharkship/features/wallet/domain/entities/coupon_entity.dart';
import 'package:sharkship/features/wallet/domain/entities/payment_request.dart';
import 'package:sharkship/features/wallet/domain/entities/payment_initiate_entity.dart';
import 'package:sharkship/features/wallet/domain/repositories/phonepe_repository.dart';
import 'package:sharkship/features/wallet/domain/usecases/start_payment_usecase.dart';
import 'package:sharkship/features/wallet/domain/usecases/start_phonepe_payment_usecase.dart';
import 'package:sharkship/features/wallet/domain/repositories/payment_repository.dart';
import 'package:sharkship/core/network/dio_exception_handler.dart';
import 'wallet_providers.dart';

part 'wallet_notifier.g.dart';

final razorpayDataSourceProvider = Provider<RazorpayDataSource>((ref) {
  final dataSource = RazorpayDataSource();
  ref.onDispose(() => dataSource.dispose());
  return dataSource;
});

final razorpayRepositoryProvider = Provider<PaymentRepository>((ref) {
  final dataSource = ref.watch(razorpayDataSourceProvider);
  return PaymentRepositoryImpl(dataSource);
});

final cashfreeDataSourceProvider = Provider<CashfreeDataSource>((ref) {
  return CashfreeDataSource();
});

// final payUDataSourceProvider = Provider<PayUDataSource>((ref) {
//   return PayUDataSource();
// });

final startPaymentUseCaseProvider = Provider<StartPaymentUseCase>((ref) {
  final repo = ref.watch(razorpayRepositoryProvider);
  return StartPaymentUseCase(repo);
});

// final phonePeDataSourceProvider = Provider<PhonePeDataSource>((ref) {
//   return PhonePeDataSource();
// });

// final phonePeRepositoryProvider = Provider<PhonePeRepository>((ref) {
//   final ds = ref.watch(phonePeDataSourceProvider);
//   return PhonePeRepositoryImpl(ds);
// });

// final startPhonePePaymentUseCaseProvider = Provider<StartPhonePePaymentUseCase>(
//   (ref) {
//     final repo = ref.watch(phonePeRepositoryProvider);
//     return StartPhonePePaymentUseCase(repo);
//   },
// );

class WalletState {
  final double amount;
  final double currentBalance;
  final CouponEntity? selectedCoupon;
  final List<CouponEntity> coupons;
  final bool isLoading;
  final bool isApplyingCoupon;
  final double? cashback;
  final String? errorMessage;
  final String selectedPaymentGateway;
  const WalletState({
    this.amount = 0,
    this.currentBalance = 0,
    this.selectedCoupon,
    this.coupons = const [],
    this.isLoading = false,
    this.isApplyingCoupon = false,
    this.cashback,
    this.errorMessage,
    this.selectedPaymentGateway = "CASHFREE",
  });

  WalletState copyWith({
    double? amount,
    double? currentBalance,
    CouponEntity? Function()? selectedCoupon,
    List<CouponEntity>? coupons,
    bool? isLoading,
    bool? isApplyingCoupon,
    double? Function()? cashback,
    String? Function()? errorMessage,
    String? selectedPaymentGateway,
  }) {
    return WalletState(
      amount: amount ?? this.amount,
      currentBalance: currentBalance ?? this.currentBalance,
      selectedCoupon: selectedCoupon != null
          ? selectedCoupon()
          : this.selectedCoupon,
      coupons: coupons ?? this.coupons,
      isLoading: isLoading ?? this.isLoading,
      isApplyingCoupon: isApplyingCoupon ?? this.isApplyingCoupon,
      cashback: cashback != null ? cashback() : this.cashback,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      selectedPaymentGateway:
          selectedPaymentGateway ?? this.selectedPaymentGateway,
    );
  }
}

@riverpod
class WalletNotifier extends _$WalletNotifier {
  @override
  WalletState build() {
    _initListeners();
    _fetchInitialData();
    return const WalletState(isLoading: true);
  }

  void _initListeners() {
    final razorpay = ref.read(razorpayDataSourceProvider);
    razorpay.init(
      onSuccess: _handlePaymentSuccess,
      onFailure: _handlePaymentFailure,
    );

    final cashfree = ref.read(cashfreeDataSourceProvider);
    cashfree.init(
      onSuccess: _handleCashfreeSuccess,
      onFailure: _handleCashfreeFailure,
    );
  }

  Future<void> _fetchInitialData() async {
    try {
      final couponsUseCase = ref.read(getCouponsUseCaseProvider);
      final balanceUseCase = ref.read(getUserBalanceUseCaseProvider);

      final coupons = await couponsUseCase();
      final balanceEntity = await balanceUseCase();
      final balance = double.tryParse(balanceEntity.balance) ?? 0.0;

      state = state.copyWith(
        coupons: coupons,
        currentBalance: balance,
        isLoading: false,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  void updateAmount(double value) {
    CouponEntity? currentCoupon = state.selectedCoupon;
    double? currentCashback = state.cashback;

    // Remove coupon if amount falls below minimum requirement
    if (currentCoupon != null && value < currentCoupon.minAmount) {
      currentCoupon = null;
      currentCashback = null;
    }

    state = state.copyWith(
      amount: value,
      selectedCoupon: () => currentCoupon,
      cashback: () => currentCashback,
      errorMessage: () => null,
    );
  }

  Future<void> validateAndApplyCoupon(CouponEntity coupon) async {
    if (state.amount < coupon.minAmount) {
      state = state.copyWith(
        errorMessage: () =>
            'Minimum amount for this coupon is ₹${coupon.minAmount}',
      );
      return;
    }

    state = state.copyWith(isApplyingCoupon: true, errorMessage: () => null);
    try {
      final useCase = ref.read(validateCouponUseCaseProvider);
      final result = await useCase(coupon.couponCode, state.amount);
      state = state.copyWith(
        selectedCoupon: () => coupon,
        cashback: () => result.cashbackAmt,
        isApplyingCoupon: false,
      );
    } catch (e) {
      state = state.copyWith(
        isApplyingCoupon: false,
        errorMessage: () => DioExceptionHandler.handle(e),
      );
    }
  }

  void removeCoupon() {
    state = state.copyWith(selectedCoupon: () => null, cashback: () => null);
  }

  Future<void> refreshBalance() async {
    try {
      final balanceUseCase = ref.read(getUserBalanceUseCaseProvider);
      final balanceEntity = await balanceUseCase();
      final balance = double.tryParse(balanceEntity.balance) ?? 0.0;
      state = state.copyWith(currentBalance: balance);
    } catch (_) {}
  }

  void setPaymentGateway(String value) {
    print(value);
    state = state.copyWith(selectedPaymentGateway: value);
    print(state.selectedPaymentGateway);
  }

  Future<void> initiatePayment() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    try {
      final useCase = ref.read(initiatePaymentUseCaseProvider);

      final result = await useCase(
        amount: state.amount,
        couponCode: state.selectedCoupon?.couponCode,
        paymentGateway: state.selectedPaymentGateway,
      );
      final mobileNumber = ref.read(userProvider).value?.phoneNo ?? "";

      await result.when(
        cashfree:
            (
              orderId,
              cfOrderId,
              paymentSessionId,
              amount,
              createdAt,
              status,
            ) async {
              print("Started");
              ref
                  .read(cashfreeDataSourceProvider)
                  .startPayment(
                    paymentSessionId: paymentSessionId,
                    orderId: orderId,
                  );
            },
        razorpay:
            (
              orderId,
              id,
              amount,
              amountDue,
              amountPaid,
              currency,
              createdAt,
              status,
            ) async {
              await ref
                  .read(startPaymentUseCaseProvider)
                  .call(
                    PaymentRequest(
                      amount: state.amount,
                      orderId: id,
                      mobileNumber: mobileNumber,
                    ),
                  );
            },
        payu:
            (
              orderId,
              key,
              txnid,
              amount,
              hash,
              surl,
              furl,
              productInfo,
              firstName,
              email,
              phone,
            ) async {
              // final payUPaymentParams = {
              //   "key": key,
              //   "transactionId": txnid,
              //   "amount": amount.toString(),
              //   "productInfo": productInfo,
              //   "firstName": firstName,
              //   "email": email,
              //   "phone": phone,
              //   "surl": surl,
              //   "furl": furl,
              //   "hash": hash,
              // };
              // ref.read(payUDataSourceProvider).startPayment(
              //       payUPaymentParams: payUPaymentParams,
              //       payUCheckoutProConfig: {"primaryColor": "#2D7FB8"},
              //       onPaymentSuccess: _handlePayUSuccess,
              //       onPaymentFailure: _handlePayUFailure,
              //       onPaymentCancel: (msg) => _handlePayUFailure({"message": "Cancelled"}),
              //     );
            },
      );

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => DioExceptionHandler.handle(e),
      );
    }
  }

  void _handleCashfreeSuccess(String orderId) {
    _verifyPayment(orderId, 'CASHFREE');
  }

  void _handleCashfreeFailure(dynamic response, String orderId) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: () => 'Payment failed',
    );
  }

  void _handlePayUSuccess(dynamic response) {
    final orderId = response['txnid'] ?? '';
    _verifyPayment(orderId, 'PAYU');
  }

  void _handlePayUFailure(dynamic response) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: () => response['message'] ?? 'Payment failed',
    );
  }

  Future<void> _verifyPayment(String orderId, String gateway) async {
    state = state.copyWith(isLoading: true);
    try {
      final useCase = ref.read(confirmPaymentUseCaseProvider);
      await useCase(orderId: orderId, paymentGateway: gateway);

      state = state.copyWith(
        isLoading: false,
        amount: 0,
        selectedCoupon: () => null,
        cashback: () => null,
      );
      refreshBalance();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => DioExceptionHandler.handle(e),
      );
    }
  }

  Future<void> _handlePhonePeResponse(
    Map<String, dynamic>? response,
    String orderId,
  ) async {
    if (response == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => 'Payment cancelled',
      );
      return;
    }

    final status = response['status'];

    if (status == 'SUCCESS') {
      // ⚠️ DO NOT trust this
      await _verifyPhonePePayment(orderId);
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => 'Payment failed: $status',
      );
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    state = state.copyWith(isLoading: true);
    try {
      final useCase = ref.read(confirmPaymentUseCaseProvider);
      await useCase(
        orderId: response.orderId ?? '',
        paymentId: response.paymentId ?? '',
        signature: response.signature ?? '',
        paymentGateway: 'RAZORPAY',
      );

      state = state.copyWith(
        isLoading: false,
        amount: 0,
        selectedCoupon: () => null,
        cashback: () => null,
      );
      refreshBalance();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => DioExceptionHandler.handle(e),
      );
    }
  }

  void _handlePaymentFailure(PaymentFailureResponse response) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: () => response.message ?? 'Payment Failed',
    );
  }

  Future<void> _verifyPhonePePayment(String orderId) async {
    try {
      final useCase = ref.read(confirmPaymentUseCaseProvider);

      await ref
          .read(confirmPaymentUseCaseProvider)
          .call(orderId: orderId, paymentGateway: 'PHONEPE');

      state = state.copyWith(
        isLoading: false,
        amount: 0,
        selectedCoupon: () => null,
        cashback: () => null,
      );

      refreshBalance();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: () => DioExceptionHandler.handle(e),
      );
    }
  }
}
