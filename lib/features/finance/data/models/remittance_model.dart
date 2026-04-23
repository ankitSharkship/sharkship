import 'package:sharkship/features/finance/domain/entities/remittance_entity.dart';

class RemittanceDetailsModel extends RemittanceDetails {
  const RemittanceDetailsModel({
    required super.totalRemittancePaid,
    super.totalCodCollected,
    required super.upcomingRemittance,
    required super.dueRemittance,
    required super.showDetails,
    required super.holdingPeriod,
    required super.holdingPercentage,
    required super.lastRemittancePaid,
  });

  factory RemittanceDetailsModel.fromJson(Map<String, dynamic> json) {
    return RemittanceDetailsModel(
      totalRemittancePaid: (json['total_remittance_paid'] as num).toDouble(),
      totalCodCollected: (json['total_cod_collected'] as num?)?.toDouble(),
      upcomingRemittance: (json['upcoming_remittance'] as num).toDouble(),
      dueRemittance: (json['due_remittance'] as num).toDouble(),
      showDetails: json['show_details'] as bool,
      holdingPeriod: json['holding_period'] as int,
      holdingPercentage: json['holding_percentage'] as int,
      lastRemittancePaid: (json['last_remittance_paid'] as num).toDouble(),
    );
  }
}

class RemittanceCycleModel extends RemittanceCycle {
  const RemittanceCycleModel({
    required super.id,
    required super.payableAmount,
    required super.startDeliveryDate,
    required super.endDeliveryDate,
    required super.remittanceDate,
    required super.status,
    required super.codCollected,
    required super.shippingDeduction,
    required super.rtoDeduction,
    required super.weightDisputeDeduction,
    required super.grossRemittanceAmount,
    required super.netRemittanceAmount,
    required super.carryforwardAmount,
    super.earlyRemittanceFee,
    super.fulfillmentReference,
    super.fulfillmentDate,
    required super.cycleName,
    required super.startShippingDate,
    required super.endShippingDate,
    required super.isShippingActive,
    required super.isDeliveryActive,
  });

  factory RemittanceCycleModel.fromJson(Map<String, dynamic> json) {
    return RemittanceCycleModel(
      id: json['id'] as String,
      payableAmount: (json['payable_amount'] as num).toDouble(),
      startDeliveryDate: DateTime.parse(json['start_delivery_date'] as String),
      endDeliveryDate: DateTime.parse(json['end_delivery_date'] as String),
      remittanceDate: DateTime.parse(json['remittanceDate'] as String),
      status: json['status'] as String,
      codCollected: (json['cod_collected'] as num).toDouble(),
      shippingDeduction: (json['shipping_deduction'] as num).toDouble(),
      rtoDeduction: (json['rto_deduction'] as num).toDouble(),
      weightDisputeDeduction: (json['weight_dispute_deduction'] as num).toDouble(),
      grossRemittanceAmount: (json['gross_remittance_amount'] as num).toDouble(),
      netRemittanceAmount: (json['net_remittance_amount'] as num).toDouble(),
      carryforwardAmount: (json['carryforward_amount'] as num).toDouble(),
      earlyRemittanceFee: (json['early_remittance_fee'] as num?)?.toDouble(),
      fulfillmentReference: json['fulfillment_reference'] as String?,
      fulfillmentDate: json['fulfillment_date'] != null
          ? DateTime.parse(json['fulfillment_date'] as String)
          : null,
      cycleName: json['cycle_name'] as String,
      startShippingDate: DateTime.parse(json['start_shipping_date'] as String),
      endShippingDate: DateTime.parse(json['end_shipping_date'] as String),
      isShippingActive: json['isShippingActive'] as bool,
      isDeliveryActive: json['isDeliveryActive'] as bool,
    );
  }
}

class RemittanceCycleResponseModel extends RemittanceCycleResponse {
  const RemittanceCycleResponseModel({
    required super.totalCount,
    required super.remittanceCycles,
  });

  factory RemittanceCycleResponseModel.fromJson(Map<String, dynamic> json) {
    return RemittanceCycleResponseModel(
      totalCount: json['totalCount'] as int,
      remittanceCycles: (json['remittanceCycles'] as List)
          .map((e) => RemittanceCycleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
