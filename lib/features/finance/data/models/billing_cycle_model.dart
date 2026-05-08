import '../../domain/entities/billing_cycle_entity.dart';

class BillingSummaryResponseModel extends BillingSummaryEntity {
  BillingSummaryResponseModel({
    required super.totalCount,
    required List<BillingCycleModel> billingCycles,
    PlanDetailsModel? planDetails,
  }) : super(
          billingCycles: billingCycles,
          planDetails: planDetails,
        );

  factory BillingSummaryResponseModel.fromJson(Map<String, dynamic> json) {
    return BillingSummaryResponseModel(
      totalCount: json['totalCount'] as int,
      billingCycles: (json['billingCycles'] as List<dynamic>)
          .map((e) => BillingCycleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      planDetails: json['planDetails'] != null
          ? PlanDetailsModel.fromJson(
              json['planDetails'] as Map<String, dynamic>)
          : null,
    );
  }
}

class PlanDetailsModel extends PlanDetailsEntity {
  PlanDetailsModel({
    required super.planName,
    required super.planDescription,
    required super.billingPeriod,
    required super.creditPeriod,
  });

  factory PlanDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlanDetailsModel(
      planName: json['plan_name'] as String,
      planDescription: json['plan_description'] as String,
      billingPeriod: json['billing_period'] as String,
      creditPeriod: json['credit_period'] as int,
    );
  }
}

class BillingCycleModel extends BillingCycleEntity {
  BillingCycleModel({
    required super.id,
    required super.cycleId,
    required super.billingStartDate,
    required super.billingEndDate,
    required super.creditStartDate,
    required super.creditEndDate,
    required super.amount,
    required super.status,
    super.invoiceNumber,
    super.invoicePdfUrl,
  });

  factory BillingCycleModel.fromJson(Map<String, dynamic> json) {
    return BillingCycleModel(
      id: json['billingCycle_id'] as String,
      cycleId: json['billingCycle_cycle_id'] as String,
      billingStartDate:
          DateTime.parse(json['billinngCycle_billing_start_date'] as String),
      billingEndDate:
          DateTime.parse(json['billingCycle_billing_end_date'] as String),
      creditStartDate:
          DateTime.parse(json['billingCycle_credit_start_date'] as String),
      creditEndDate:
          DateTime.parse(json['billingCycle_credit_end_date'] as String),
      amount: double.tryParse(json['billingCycle_amount']?.toString() ?? '0') ??
          0.0,
      status: json['billingCycle_status'] as String,
      invoiceNumber: json['invoice_number'] as String?,
      invoicePdfUrl: json['invoice_pdf_url'] as String?,
    );
  }
}
