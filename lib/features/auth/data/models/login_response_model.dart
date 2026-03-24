import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/login_response.dart';

part 'login_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({
    super.tokenType,
    super.accessToken,
    super.user,
    super.membership,
    super.userId,
    super.subUserId,
    super.refreshToken,
    super.expiresIn,
    super.refreshExpiresIn,
    super.scope,
    super.role,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
