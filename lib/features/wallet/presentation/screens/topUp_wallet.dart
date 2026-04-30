import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/shared/constants/colors.dart';

class TopupWallet extends ConsumerStatefulWidget {
  const TopupWallet({super.key});

  @override
  ConsumerState<TopupWallet> createState() => _TopupWalletState();
}

class _TopupWalletState extends ConsumerState<TopupWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      appBar: AppBar(
        backgroundColor: ColorManager.scaffoldBg,
        title: Text('Top Up Wallet'),
        centerTitle: false,
      ),
      body: SafeArea(child: Column(children: [
        
      ])),
    );
  }
}
