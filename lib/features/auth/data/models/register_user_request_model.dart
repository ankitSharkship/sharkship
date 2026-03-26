class RegisterUserRequestModel {
  final String otp;
  final String verifyId;
  final String firstName;
  final String lastName;
  final int phoneNo;
  final String password;
  final String email;
  final String businessName;
  final String typeOfBusiness;
  final String entityType;
  final BusinessAddressModel businessAddress;

  const RegisterUserRequestModel({
    required this.otp,
    required this.verifyId,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.password,
    required this.email,
    required this.businessName,
    required this.typeOfBusiness,
    required this.entityType,
    required this.businessAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
      "verifyId": verifyId,
      "firstName": firstName,
      "lastName": lastName,
      "phone_no": phoneNo,
      "password": password,
      "email": email,
      "businessName": businessName,
      "typeOfBusiness": typeOfBusiness,
      "entityType": entityType,
      "businessAddress": businessAddress.toJson(),
    };
  }
}

class BusinessAddressModel {
  final String addressLane1;
  final String landmark;
  final int pin;
  final String city;
  final String state;
  final String name;
  final String phoneNo;

  const BusinessAddressModel({
    required this.addressLane1,
    required this.landmark,
    required this.pin,
    required this.city,
    required this.state,
    required this.name,
    required this.phoneNo,
  });

  Map<String, dynamic> toJson() {
    return {
      "address_lane1": addressLane1,
      "landmark": landmark,
      "Pin": pin,
      "city": city,
      "state": state,
      "name": name,
      "phone_no": phoneNo,
    };
  }
}
