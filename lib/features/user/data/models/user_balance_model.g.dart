// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBalanceModel _$UserBalanceModelFromJson(Map<String, dynamic> json) =>
    UserBalanceModel(
      activeWallet: json['active_wallet'] as String,
      balance: json['balance'] as String,
    );

Map<String, dynamic> _$UserBalanceModelToJson(UserBalanceModel instance) =>
    <String, dynamic>{
      'active_wallet': instance.activeWallet,
      'balance': instance.balance,
    };
