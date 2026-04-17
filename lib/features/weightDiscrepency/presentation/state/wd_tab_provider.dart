import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'wd_tab_provider.g.dart';

@riverpod
class WdTab extends _$WdTab {
  @override
  int build() => 0;
  void setTab(int index) {
    state = index;
    print('object');
    print(index);
  }
}

final ndrTabs = ["Disputed", "Pending", "Complete", "Cancelled", "All"];
