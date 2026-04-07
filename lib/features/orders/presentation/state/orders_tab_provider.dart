import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'orders_tab_provider.g.dart';

@riverpod
class OrdersTab extends _$OrdersTab {
  @override
  int build() => 0;
  void setTab(int index) => state = index;
}

final orderTabs = ["To Be Processed", "Failed To Process"];
