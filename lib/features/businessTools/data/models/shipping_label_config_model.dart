import 'package:sharkship/features/businessTools/domain/entities/shipping_label_config_entity.dart';

class ShippingLabelConfigModel extends ShippingLabelConfigEntity {
  const ShippingLabelConfigModel({
    required super.id,
    required super.rtoVisibility,
    required super.sharkshipVisibility,
    required super.logoVisibility,
    required super.gstVisibility,
    required super.clientVisibility,
    required super.skuVisibility,
    required super.alterName,
    required super.phoneVisibility,
    required super.rtoPhoneVisibility,
    required super.tableVisibility,
    required super.isAmountVisible,
    required super.newName,
    required super.labelSize,
  });

  factory ShippingLabelConfigModel.fromJson(Map<String, dynamic> json) {
    return ShippingLabelConfigModel(
      id: json['id'] as int,
      rtoVisibility: json['rto_visibility'] as bool,
      sharkshipVisibility: json['sharkship_visibility'] as bool,
      logoVisibility: json['logo_visibility'] as bool,
      gstVisibility: json['gst_visibility'] as bool,
      clientVisibility: json['client_visibility'] as bool,
      skuVisibility: json['sku_visibility'] as bool,
      alterName: json['alter_name'] as bool,
      phoneVisibility: json['phone_visibility'] as bool,
      rtoPhoneVisibility: json['rto_phone_visibility'] as bool,
      tableVisibility: json['table_visibility'] as bool,
      isAmountVisible: json['isAmountVisible'] as bool,
      newName: json['newName'] as String? ?? '',
      labelSize: json['labelSize'] as String? ?? 'STANDARD',
    );
  }

  Map<String, dynamic> toPutPayload() {
    return {
      'rtoAddressVisible': rtoVisibility,
      'sharkshipVisible': sharkshipVisibility,
      'clientIdVisible': clientVisibility,
      'sellerLogoVisible': logoVisibility,
      'gstVisible': gstVisibility,
      'skuVisible': skuVisibility,
      'alterName': alterName,
      'phoneVisible': phoneVisibility,
      'sellerPhoneVisible': rtoPhoneVisibility,
      'isAmountVisible': isAmountVisible,
      'tableVisible': tableVisibility,
      'newName': newName,
      'labelSize': labelSize,
    };
  }
}
