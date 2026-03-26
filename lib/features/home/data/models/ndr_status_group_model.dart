import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/ndr_status_group.dart';
import 'ndr_status_count_item_model.dart';

part 'ndr_status_group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NdrStatusGroupModel extends NdrStatusGroup {
  @override
  @JsonKey(name: 'NDRorders')
  final List<NdrStatusCountItemModel> ndrOrders;

  @override
  final List<NdrStatusCountItemModel> reattemptOrders;

  @override
  final List<NdrStatusCountItemModel> deliveredOrders;

  @override
  final List<NdrStatusCountItemModel> returnedOrders;

  const NdrStatusGroupModel({
    required this.ndrOrders,
    required this.reattemptOrders,
    required this.deliveredOrders,
    required this.returnedOrders,
  }) : super(
          ndrOrders: ndrOrders,
          reattemptOrders: reattemptOrders,
          deliveredOrders: deliveredOrders,
          returnedOrders: returnedOrders,
        );

  factory NdrStatusGroupModel.fromJson(Map<String, dynamic> json) =>
      _$NdrStatusGroupModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NdrStatusGroupModelToJson(this);
}
