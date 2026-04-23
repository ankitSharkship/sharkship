import 'package:flutter_riverpod/legacy.dart';

enum TsFilterTab { walletType, orderDescType, journeyType, txnType }

final selectedTsFilterTabProvider = StateProvider<TsFilterTab>(
  (ref) => TsFilterTab.walletType,
);

final tsWalletTypeFilterProvider = StateProvider<String?>((ref) => "All");

final tsOrderDescTypeFilterProvider = StateProvider<String?>((ref) => "All");
final tsJourneyTypeFilterProvider = StateProvider<String?>((ref) => "All");

final tsTxnTypeFilterProvider = StateProvider<String?>((ref) => "All");


class SearchState {
  final SearchType type;
  final String value;
  final bool active;

  const SearchState({
    required this.type,
    required this.value,
    required this.active,
  });

  SearchState copyWith({
    SearchType? type,
    String? value,
    bool? active,
  }) {
    return SearchState(
      type: type ?? this.type,
      value: value ?? this.value,
      active: active ?? this.active,
    );
  }
}

final tsSearchProvider = StateProvider<SearchState>(
  (ref) => const SearchState(
    type: SearchType.orderId,
    value: '',
    active: false,
  ),
);
enum SearchType { orderId, trackingId, txnId }