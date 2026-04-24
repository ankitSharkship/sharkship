import 'package:sharkship/features/finance/domain/entities/tax_invoice_entity.dart';

class TaxInvoiceModel extends TaxInvoiceEntity {
  TaxInvoiceModel({
    required super.id,
    required super.createdAt,
    required super.month,
    required super.year,
    required super.isExcelDownloaded,
    required super.isPdfDownloaded,
    required super.isAdmin,
    required super.totalAmount,
    required super.invoiceNo,
    required super.cgst,
    required super.sgst,
    required super.igst,
    required super.placeOfSupply,
    super.billingCycle,
  });

  factory TaxInvoiceModel.fromJson(Map<String, dynamic> json) {
    return TaxInvoiceModel(
      id: json['id'] ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      month: json['month'] ?? '',
      year: json['year'] ?? 0,
      isExcelDownloaded: json['is_excel_downloaded'] ?? false,
      isPdfDownloaded: json['is_pdf_downloaded'] ?? false,
      isAdmin: json['is_admin'] ?? false,
      totalAmount: json['total_amount'] ?? '0.00',
      invoiceNo: json['invoice_no'] ?? '',
      cgst: json['cgst'] ?? '0.00',
      sgst: json['sgst'] ?? '0.00',
      igst: json['igst'] ?? '0.00',
      placeOfSupply: json['place_of_supply'] ?? '',
      billingCycle: json['billingCycle'],
    );
  }
}

class TaxInvoiceResponseModel extends TaxInvoiceResponseEntity {
  TaxInvoiceResponseModel({
    required super.totalCount,
    required super.invoices,
  });

  factory TaxInvoiceResponseModel.fromJson(Map<String, dynamic> json) {
    final invoiceList = json['invoices'] as List?;
    return TaxInvoiceResponseModel(
      totalCount: json['totalCount'] ?? 0,
      invoices: invoiceList != null
          ? invoiceList.map((e) => TaxInvoiceModel.fromJson(e)).toList()
          : [],
    );
  }
}
