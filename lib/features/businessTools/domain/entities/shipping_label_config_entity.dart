import 'package:equatable/equatable.dart';

class ShippingLabelConfigEntity extends Equatable {
  final int id;
  final bool rtoVisibility;
  final bool sharkshipVisibility;
  final bool logoVisibility;
  final bool gstVisibility;
  final bool clientVisibility;
  final bool skuVisibility;
  final bool alterName;
  final bool phoneVisibility;
  final bool rtoPhoneVisibility;
  final bool tableVisibility;
  final bool isAmountVisible;
  final String newName;
  final String labelSize;

  const ShippingLabelConfigEntity({
    required this.id,
    required this.rtoVisibility,
    required this.sharkshipVisibility,
    required this.logoVisibility,
    required this.gstVisibility,
    required this.clientVisibility,
    required this.skuVisibility,
    required this.alterName,
    required this.phoneVisibility,
    required this.rtoPhoneVisibility,
    required this.tableVisibility,
    required this.isAmountVisible,
    required this.newName,
    required this.labelSize,
  });

  @override
  List<Object?> get props => [
        id,
        rtoVisibility,
        sharkshipVisibility,
        logoVisibility,
        gstVisibility,
        clientVisibility,
        skuVisibility,
        alterName,
        phoneVisibility,
        rtoPhoneVisibility,
        tableVisibility,
        isAmountVisible,
        newName,
        labelSize,
      ];
}
