import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sc_tab_provider.g.dart';

@riverpod
class ScTab extends _$ScTab {
  @override
  int build() => 0;
  void setTab(int index) {
    state = index;
    print('object');
    print(index);
  }
}

final scTabs = ["PAN INDIA", "SDD/NDD"];
