class BillingSummaryEntity {
  final int totalCount;
  final List<BillingCycleEntity> billingCycles;
  final PlanDetailsEntity? planDetails;

  BillingSummaryEntity({
    required this.totalCount,
    required this.billingCycles,
    this.planDetails,
  });
}

class PlanDetailsEntity {
  final String planName;
  final String planDescription;
  final String billingPeriod;
  final int creditPeriod;

  PlanDetailsEntity({
    required this.planName,
    required this.planDescription,
    required this.billingPeriod,
    required this.creditPeriod,
  });
}

class BillingCycleEntity {
  final String id;
  final String cycleId;
  final DateTime billingStartDate;
  final DateTime billingEndDate;
  final DateTime creditStartDate;
  final DateTime creditEndDate;
  final double amount;
  final String status;
  final String? invoiceNumber;
  final String? invoicePdfUrl;

  BillingCycleEntity({
    required this.id,
    required this.cycleId,
    required this.billingStartDate,
    required this.billingEndDate,
    required this.creditStartDate,
    required this.creditEndDate,
    required this.amount,
    required this.status,
    this.invoiceNumber,
    this.invoicePdfUrl,
  });
}
