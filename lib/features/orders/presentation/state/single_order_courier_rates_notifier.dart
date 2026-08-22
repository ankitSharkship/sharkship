import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/courier_rate_entity.dart';
import '../../domain/repositories/orders_repository.dart';
import 'orders_provider.dart';

part 'single_order_courier_rates_notifier.g.dart';

/// Fetches live courier rates for a specific order + pickup address, used
/// only by the single-order ship flow's "Select Courier" step.
@riverpod
Future<OrderCourierRatesEntity> singleOrderCourierRates(
  Ref ref,
  (int orderId, int pickupAddressId) key,
) {
  final useCase = ref.watch(getOrderCourierRatesUseCaseProvider);
  return useCase.execute(
    OrderCourierRatesParams(orderId: key.$1, pickupAddressId: key.$2),
  );
}
