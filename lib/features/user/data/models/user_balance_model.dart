import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_balance.dart';

part 'user_balance_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserBalanceModel extends UserBalance {
  const UserBalanceModel({
    required super.activeWallet,
    required super.balance,
  });

  factory UserBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$UserBalanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBalanceModelToJson(this);
}
