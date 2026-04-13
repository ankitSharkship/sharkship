import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shipment_tab_provider.g.dart';

@riverpod
class ShipmentTab extends _$ShipmentTab {
  @override
  int build() => 0;
  void setTab(int index) => state = index;
}

final shipmentTabs = [
  "Ready To Ship",
  "Shipped",
  "Out For Delivery",
  "Delivered",
  "RTO",
  "Cancelled",
  "All Orders",
];
