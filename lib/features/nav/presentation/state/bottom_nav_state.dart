import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_state.g.dart';

@riverpod
class BottomNav extends _$BottomNav {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}
