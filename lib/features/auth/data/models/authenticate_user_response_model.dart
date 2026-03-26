import 'package:json_annotation/json_annotation.dart';
import 'package:sharkship/features/auth/domain/entities/authenticate_user_response.dart';

part 'authenticate_user_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthenticateUserModel extends AuthenticateUser {
  const AuthenticateUserModel({
    required super.verifyId,
    required super.message,
  });

  factory AuthenticateUserModel.fromJson(Map<String, dynamic> json) {
    return AuthenticateUserModel(
      verifyId: json['verify_id'],
      message: json['message'],
    );
  }
}
