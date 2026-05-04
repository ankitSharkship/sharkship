import 'package:flutter_riverpod/flutter_riverpod.dart';

// final walletProvider =
//     AsyncNotifierProvider<WalletNotifier, dynamic>(WalletNotifier.new);

// class WalletNotifier extends AsyncNotifier<Wallet> {
//   @override
//   Future<Wallet> build() async {
//     return ref.read(walletRepo).fetchWallet();
//   }

//   Future<void> refresh() async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(() => build());
//   }
// }