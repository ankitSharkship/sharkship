import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_tab_provider.g.dart';

@riverpod
class DashboardTab extends _$DashboardTab {
  @override
  int build() => 0;

  void setTab(int index) => state = index;
}

final dashboardTabs = [
  "Overview",
  "Pickups",
  "NDR",
  "RTO",
  "Delivered",
  "Revenue",
  "SMS",
];