import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_orders_tab_provider.g.dart';

@riverpod
class CreateOrdersTab extends _$CreateOrdersTab {
  @override
  int build() => 0;
  void setTab(int index) => state = index;
}

final orderTabs = ["Single Order", "Bulk Order"];
