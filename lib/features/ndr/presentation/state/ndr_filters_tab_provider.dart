import 'package:flutter_riverpod/legacy.dart';

enum NdrFilterTab {
  carrier,
  paymentType,
}

final selectedNdrFilterTabProvider = StateProvider<NdrFilterTab>(
  (ref) => NdrFilterTab.carrier,
);

final ndrCarrierFilterProvider = StateProvider<String?>((ref) => "All");

final ndrPaymentTypeFilterProvider = StateProvider<String?>(
  (ref) => "All",
);

class RadioItems {
  final String displayName;
  final String value;
  RadioItems({required this.displayName, required this.value});
}
