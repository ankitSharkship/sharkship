import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/otp_response.dart';

part 'otp_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OtpResponseModel extends OtpResponse {
  const OtpResponseModel({
    required super.verifyId,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResponseModelToJson(this);
}
