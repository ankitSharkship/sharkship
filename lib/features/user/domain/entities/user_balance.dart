import 'package:equatable/equatable.dart';

class UserBalance extends Equatable {
  final String activeWallet;
  final String balance;

  const UserBalance({
    required this.activeWallet,
    required this.balance,
  });

  @override
  List<Object?> get props => [activeWallet, balance];
}
