import 'package:flutter_riverpod/legacy.dart';

enum ShipmentFilterTab {
  channels,
  courierServiceType,
  pickupAddress,
  whatsappConfirmation,
  paymentType,
}

final selectedShipmentFilterTabProvider = StateProvider<ShipmentFilterTab>(
  (ref) => ShipmentFilterTab.channels,
);

final shipmentChannelFilterProvider = StateProvider<String?>((ref) => "All");
final shipmentCourierServiceTypeFilterProvider = StateProvider<String?>(
  (ref) => "All",
);

final shipmentPickupAddressFilterProvider = StateProvider<String?>(
  (ref) => null,
);

final shipmentWhatsappConfirmationFilterProvider = StateProvider<String?>(
  (ref) => "All",
);
final shipmentPaymentTypeFilterProvider = StateProvider<String?>(
  (ref) => "All",
);

class RadioItems {
  final String displayName;
  final String value;
  RadioItems({required this.displayName, required this.value});
}
