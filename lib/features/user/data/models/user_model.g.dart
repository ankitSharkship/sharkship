// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String?,
  lastName: json['last_name'] as String,
  phoneNo: json['phone_no'] as String,
  email: json['email'] as String,
  status: json['status'] as String,
  verificationStatus: json['verification_status'] as String,
  type: json['type'] as String,
  businessName: json['business_name'] as String?,
  profileImageUrl: json['profile_image_url'] as String?,
  typeOfBusiness: json['type_of_business'] as String?,
  entityType: json['entity_type'] as String?,
  isKycVerified: json['isKycVerified'] as bool? ?? false,
  kycStep: json['kyc_step'] as String?,
  kycTicketStatus: json['kyc_ticket_status'] as String?,
  agreementAccept: json['agreement_accept'] as bool? ?? false,
  lastLogin: json['last_login'] as String?,
  createdAt: json['created_at'] as String?,
  kam: json['kam'] == null
      ? null
      : KamModel.fromJson(json['kam'] as Map<String, dynamic>),
  isWhatsappSms: json['isWhatsappSms'] as bool?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'middle_name': instance.middleName,
  'last_name': instance.lastName,
  'phone_no': instance.phoneNo,
  'email': instance.email,
  'status': instance.status,
  'verification_status': instance.verificationStatus,
  'type': instance.type,
  'business_name': instance.businessName,
  'profile_image_url': instance.profileImageUrl,
  'type_of_business': instance.typeOfBusiness,
  'entity_type': instance.entityType,
  'kyc_step': instance.kycStep,
  'kyc_ticket_status': instance.kycTicketStatus,
  'last_login': instance.lastLogin,
  'created_at': instance.createdAt,
  'kam': instance.kam?.toJson(),
  'isKycVerified': instance.isKycVerified,
  'agreement_accept': instance.agreementAccept,
  'isWhatsappSms': instance.isWhatsappSms,
};

KamModel _$KamModelFromJson(Map<String, dynamic> json) => KamModel(
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
);

Map<String, dynamic> _$KamModelToJson(KamModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
};
