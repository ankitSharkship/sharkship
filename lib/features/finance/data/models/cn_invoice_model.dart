import 'package:sharkship/features/finance/domain/entities/cn_invoice_entity.dart';

class CnInvoiceModel extends CnInvoiceEntity {
  CnInvoiceModel({
    required super.id,
    required super.createdAt,
    required super.cnStartDate,
    required super.cnEndDate,
    required super.cnDate,
    required super.isExcelDownloaded,
    required super.isPdfDownloaded,
    required super.totalAmount,
    required super.invoiceNo,
    required super.state,
    super.cgst,
    super.sgst,
    super.igst,
    super.placeOfSupply,
  });

  factory CnInvoiceModel.fromJson(Map<String, dynamic> json) {
    return CnInvoiceModel(
      id: json['id'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      cnStartDate: json['cn_start_date'] != null
          ? DateTime.parse(json['cn_start_date'])
          : DateTime.now(),
      cnEndDate: json['cn_end_date'] != null
          ? DateTime.parse(json['cn_end_date'])
          : DateTime.now(),
      cnDate: json['cn_date'] != null
          ? DateTime.parse(json['cn_date'])
          : DateTime.now(),
      isExcelDownloaded: json['is_excel_downloaded'] ?? false,
      isPdfDownloaded: json['is_pdf_downloaded'] ?? false,
      totalAmount: json['total_amount']?.toString() ?? '0.00',
      invoiceNo: json['invoice_no'] ?? '',
      state: json['state'] ?? '',
      cgst: json['cgst']?.toString(),
      sgst: json['sgst']?.toString(),
      igst: json['igst']?.toString(),
      placeOfSupply: json['place_of_supply']?.toString(),
    );
  }
}

class CnInvoiceResponseModel extends CnInvoiceResponseEntity {
  CnInvoiceResponseModel({
    required super.totalCount,
    required super.invoices,
  });

  factory CnInvoiceResponseModel.fromJson(Map<String, dynamic> json) {
    return CnInvoiceResponseModel(
      totalCount: json['totalCount'] ?? 0,
      invoices:
          (json['invoices'] as List?)
              ?.map((e) => CnInvoiceModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
