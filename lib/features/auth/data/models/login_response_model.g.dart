// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      tokenType: json['token_type'] as String?,
      accessToken: json['access_token'] as String?,
      user: json['user'] as String?,
      membership: json['membership'] as String?,
      userId: json['user_id'] as String?,
      subUserId: json['sub_user_id'] as String?,
      refreshToken: json['refresh_token'] as String?,
      expiresIn: json['expires_in'] as String?,
      refreshExpiresIn: json['refresh_expires_in'] as String?,
      scope: (json['scope'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      role: json['role'] as String?,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'token_type': instance.tokenType,
      'access_token': instance.accessToken,
      'user': instance.user,
      'membership': instance.membership,
      'user_id': instance.userId,
      'sub_user_id': instance.subUserId,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
      'refresh_expires_in': instance.refreshExpiresIn,
      'scope': instance.scope,
      'role': instance.role,
    };
