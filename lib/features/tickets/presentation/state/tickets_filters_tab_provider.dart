import 'package:flutter_riverpod/legacy.dart';

enum TicketsFilterTab { categoryType }

final selectedTicketsFilterTabProvider = StateProvider<TicketsFilterTab>(
  (ref) => TicketsFilterTab.categoryType,
);

final ticketsCategoryTypeFilterProvider = StateProvider<String?>((ref) => "All");
