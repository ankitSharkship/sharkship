class RemittanceDetails {
  final double totalRemittancePaid;
  final double? totalCodCollected;
  final double upcomingRemittance;
  final double dueRemittance;
  final bool showDetails;
  final int holdingPeriod;
  final int holdingPercentage;
  final double lastRemittancePaid;

  const RemittanceDetails({
    required this.totalRemittancePaid,
    this.totalCodCollected,
    required this.upcomingRemittance,
    required this.dueRemittance,
    required this.showDetails,
    required this.holdingPeriod,
    required this.holdingPercentage,
    required this.lastRemittancePaid,
  });
}

class RemittanceCycle {
  final String id;
  final double payableAmount;
  final DateTime startDeliveryDate;
  final DateTime endDeliveryDate;
  final DateTime remittanceDate;
  final String status;
  final double codCollected;
  final double shippingDeduction;
  final double rtoDeduction;
  final double weightDisputeDeduction;
  final double grossRemittanceAmount;
  final double netRemittanceAmount;
  final double carryforwardAmount;
  final double? earlyRemittanceFee;
  final String? fulfillmentReference;
  final DateTime? fulfillmentDate;
  final String cycleName;
  final DateTime startShippingDate;
  final DateTime endShippingDate;
  final bool isShippingActive;
  final bool isDeliveryActive;

  const RemittanceCycle({
    required this.id,
    required this.payableAmount,
    required this.startDeliveryDate,
    required this.endDeliveryDate,
    required this.remittanceDate,
    required this.status,
    required this.codCollected,
    required this.shippingDeduction,
    required this.rtoDeduction,
    required this.weightDisputeDeduction,
    required this.grossRemittanceAmount,
    required this.netRemittanceAmount,
    required this.carryforwardAmount,
    this.earlyRemittanceFee,
    this.fulfillmentReference,
    this.fulfillmentDate,
    required this.cycleName,
    required this.startShippingDate,
    required this.endShippingDate,
    required this.isShippingActive,
    required this.isDeliveryActive,
  });
}

class RemittanceCycleResponse {
  final int totalCount;
  final List<RemittanceCycle> remittanceCycles;

  const RemittanceCycleResponse({
    required this.totalCount,
    required this.remittanceCycles,
  });
}
