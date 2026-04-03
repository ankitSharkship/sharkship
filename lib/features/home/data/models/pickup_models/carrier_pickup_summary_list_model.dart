import 'package:sharkship/features/home/data/models/pickup_models/carrier_pickup_summary_model.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';

class CarrierPickupSummaryListModel extends CarrierPickupSummaryList {
  const CarrierPickupSummaryListModel({
    required List<CarrierPickupSummaryModel> items,
  }) : super(items: items);

  factory CarrierPickupSummaryListModel.fromJson(List<dynamic> json) {
    return CarrierPickupSummaryListModel(
      items: json.map((e) => CarrierPickupSummaryModel.fromJson(e)).toList(),
    );
  }
}
