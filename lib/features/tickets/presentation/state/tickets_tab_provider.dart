import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tickets_tab_provider.g.dart';

@riverpod
class TicketsTab extends _$TicketsTab {
  @override
  int build() => 0;
  void setTab(int index) {
    state = index;
  }
}

final ticketsTabs = ["Pending", "Resolved", "Rejected", "Initiated"];
