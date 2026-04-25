import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String phoneNo;
  final String email;
  final String status;
  final String verificationStatus;
  final String type;
  final String? businessName;
  final String? profileImageUrl;
  final String? typeOfBusiness;
  final String? entityType;
  final bool isKycVerified;
  final String? kycStep;
  final String? kycTicketStatus;
  final bool agreementAccept;
  final String? lastLogin;
  final String? createdAt;
  final Kam? kam;
  final bool? isWhatsappSms;

  const User({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.phoneNo,
    required this.email,
    required this.status,
    required this.verificationStatus,
    required this.type,
    this.businessName,
    this.profileImageUrl,
    this.typeOfBusiness,
    this.entityType,
    required this.isKycVerified,
    this.kycStep,
    this.kycTicketStatus,
    required this.agreementAccept,
    this.lastLogin,
    this.createdAt,
    this.kam,
    this.isWhatsappSms
  });

  @override
  List<Object?> get props => [id, phoneNo, email];
}

class Kam extends Equatable {
  final String name;
  final String email;
  final String phone;

  const Kam({required this.name, required this.email, required this.phone});

  @override
  List<Object?> get props => [name, email, phone];
}
