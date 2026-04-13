import 'package:flutter_riverpod/legacy.dart';

// enum BottomTab { home, orders, shipments, support, more }

final bottomNavProvider = StateProvider<int>((ref) => 0);
