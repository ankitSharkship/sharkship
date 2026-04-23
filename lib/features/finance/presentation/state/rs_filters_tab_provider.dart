import 'package:flutter_riverpod/legacy.dart';

enum RsFilterTab { status }

final selectedRsFilterTabProvider = StateProvider<RsFilterTab>(
  (ref) => RsFilterTab.status,
);

final rsStatusTypeFilterProvider = StateProvider<String?>((ref) => "All");