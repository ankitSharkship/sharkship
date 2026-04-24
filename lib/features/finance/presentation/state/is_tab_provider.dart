import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'is_tab_provider.g.dart';

@riverpod
class IsTab extends _$IsTab {
  @override
  int build() => 0;
  void setTab(int index) {
    state = index;
    // Reset search when tab changes
  }
}

final isTabs = ["Tax Invoice", "CN Invoice"];
