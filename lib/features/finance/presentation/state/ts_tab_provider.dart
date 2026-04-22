import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'ts_filters_tab_provider.dart';

part 'ts_tab_provider.g.dart';

@riverpod
class TsTab extends _$TsTab {
  @override
  int build() => 0;
  void setTab(int index) {
    state = index;
    // Reset search when tab changes

    ref.read(tsSearchProvider.notifier).state = SearchState(
      type: index == 0 ? SearchType.orderId : SearchType.txnId,
      value: '',
      active: false,
    );
  }
}

final tsTabs = ["Order Txns", "Wallet Txns", "SMS Txns"];
