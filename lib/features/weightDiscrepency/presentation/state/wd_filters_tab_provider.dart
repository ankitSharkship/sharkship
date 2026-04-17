import 'package:flutter_riverpod/legacy.dart';

enum WdFilterTab { carrier }

final selectedWdFilterTabProvider = StateProvider<WdFilterTab>(
  (ref) => WdFilterTab.carrier,
);

final wdCarrierFilterProvider = StateProvider<String?>((ref) => "ALL");

final wdPaymentTypeFilterProvider = StateProvider<String?>((ref) => "ALL");

class RadioItems {
  final String displayName;
  final String value;
  RadioItems({required this.displayName, required this.value});
}
