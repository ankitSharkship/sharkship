import 'package:flutter_riverpod/legacy.dart';

enum OrderFilterTab {
  channels,
  courierServiceType,
  pickupAddress,
  whatsappConfirmation,
  paymentType,
}

final selectedOrderFilterTabProvider = StateProvider<OrderFilterTab>(
  (ref) => OrderFilterTab.channels,
);

final orderChannelFilterProvider = StateProvider<String?>((ref) => "All");
final orderCourierServiceTypeFilterProvider = StateProvider<String?>(
  (ref) => "All",
);

final orderPickupAddressFilterProvider = StateProvider<String?>((ref) => null);

final orderWhatsappConfirmationFilterProvider = StateProvider<String?>(
  (ref) => "All",
);
final orderPaymentTypeFilterProvider = StateProvider<String?>((ref) => "All");

class RadioItems {
  final String displayName;
  final String value;
  RadioItems({required this.displayName, required this.value});
}
