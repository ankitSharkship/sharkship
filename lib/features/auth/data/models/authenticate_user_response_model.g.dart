// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateUserModel _$AuthenticateUserModelFromJson(
  Map<String, dynamic> json,
) => AuthenticateUserModel(
  verifyId: json['verify_id'] as String,
  message: json['message'] as String,
);

Map<String, dynamic> _$AuthenticateUserModelToJson(
  AuthenticateUserModel instance,
) => <String, dynamic>{
  'verify_id': instance.verifyId,
  'message': instance.message,
};
