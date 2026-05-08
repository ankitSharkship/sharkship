import 'package:flutter_riverpod/legacy.dart';

enum BsFilterTab {dateQuery, status }

final selectedBsFilterTabProvider = StateProvider<BsFilterTab>(
  (ref) => BsFilterTab.dateQuery,
);

final bsStatusTypeFilterProvider = StateProvider<String?>((ref) => "All");
final bsDateQueryTypeFilterProvider = StateProvider<String>((ref) => "BILLING");