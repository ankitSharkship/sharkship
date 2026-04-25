import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserModel extends User {
  @override
  @JsonKey(name: 'kam')
  final KamModel? kam;
  @override
  @JsonKey(name: 'isKycVerified', defaultValue: false)
  final bool isKycVerified;

  @override
  @JsonKey(name: 'agreement_accept', defaultValue: false)
  final bool agreementAccept;

  @override
  @JsonKey(name: 'isWhatsappSms')
  final bool? isWhatsappSms;

  const UserModel({
    required super.id,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.phoneNo,
    required super.email,
    required super.status,
    required super.verificationStatus,
    required super.type,
    super.businessName,
    super.profileImageUrl,
    super.typeOfBusiness,
    super.entityType,
    required this.isKycVerified,
    super.kycStep,
    super.kycTicketStatus,
    required this.agreementAccept,
    super.lastLogin,
    super.createdAt,
    this.kam,
    this.isWhatsappSms
  }) : super(
         kam: kam,
         isKycVerified: isKycVerified,
         agreementAccept: agreementAccept,
         isWhatsappSms: isWhatsappSms,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class KamModel extends Kam {
  const KamModel({
    required super.name,
    required super.email,
    required super.phone,
  });

  factory KamModel.fromJson(Map<String, dynamic> json) =>
      _$KamModelFromJson(json);

  Map<String, dynamic> toJson() => _$KamModelToJson(this);
}
