import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ndr_tab_provider.g.dart';

@riverpod
class NdrTab extends _$NdrTab {
  @override
  int build() => 0;
  void setTab(int index) {
    state = index;
    print('object');
    print(index);
  }
}

final ndrTabs = ["Action Required", "Action Requested", "Delivered", "RTO"];
