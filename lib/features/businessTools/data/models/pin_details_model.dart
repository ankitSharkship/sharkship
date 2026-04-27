import 'package:json_annotation/json_annotation.dart';
import 'package:sharkship/features/businessTools/domain/entities/pin_details_entity.dart';

part 'pin_details_model.g.dart';

@JsonSerializable()
class PinDetailsModel extends PinDetailsEntity {
  @override
  @JsonKey(name: 'location')
  final PinLocationModel? location;

  const PinDetailsModel({
    required super.city,
    required super.state,
    this.location,
  }) : super(location: location);

  factory PinDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PinDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PinDetailsModelToJson(this);
}

@JsonSerializable()
class PinLocationModel extends PinLocationEntity {
  const PinLocationModel({
    required super.lat,
    required super.lng,
  });

  factory PinLocationModel.fromJson(Map<String, dynamic> json) =>
      _$PinLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PinLocationModelToJson(this);
}
