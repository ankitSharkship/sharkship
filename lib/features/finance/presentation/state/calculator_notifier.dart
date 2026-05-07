import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/network/dio_exception_handler.dart';
import '../../domain/entities/calculator_rate_entity.dart';
import 'finance_providers.dart';

part 'calculator_notifier.g.dart';

@riverpod
class CalculatorNotifier extends _$CalculatorNotifier {
  @override
  AsyncValue<List<CalculatorRateEntity>> build() {
    return const AsyncValue.data([]);
  }

  Future<void> calculate({
    required String source,
    required String destination,
    required String paymentType,
    required double weight,
    required double productValue,
    required double length,
    required double width,
    required double height,
    required String serviceType,
    required String provider,
  }) async {
    state = const AsyncValue.loading();
    try {
      final rates = await ref.read(calculateShippingRateUseCaseProvider).execute(
            source: source,
            destination: destination,
            paymentType: paymentType,
            weight: weight,
            productValue: productValue,
            length: length,
            width: width,
            height: height,
            serviceType: serviceType,
            provider: provider,
          );
      state = AsyncValue.data(rates);
    } catch (e, st) {
     state = AsyncValue.error(DioExceptionHandler.handle(e), st);
    }
  }
}
