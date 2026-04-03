import 'package:json_annotation/json_annotation.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/pickup_status.dart';


part 'pickup_status_model.g.dart';

@JsonSerializable()
class PickupStatusModel extends PickupStatus {
  @override
  final int count;

  @JsonKey(name: 'orderId')
  final List<int> orderIds;

  const PickupStatusModel({
    required this.count,
    required this.orderIds,
  }) : super(
          count: count,
          orderIds: orderIds,
        );

  factory PickupStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PickupStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$PickupStatusModelToJson(this);
}