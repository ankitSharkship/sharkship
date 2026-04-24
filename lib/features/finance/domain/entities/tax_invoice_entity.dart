class TaxInvoiceEntity {
  final String id;
  final DateTime createdAt;
  final String month;
  final int year;
  final bool isExcelDownloaded;
  final bool isPdfDownloaded;
  final bool isAdmin;
  final String totalAmount;
  final String invoiceNo;
  final String cgst;
  final String sgst;
  final String igst;
  final String placeOfSupply;
  final dynamic billingCycle;

  TaxInvoiceEntity({
    required this.id,
    required this.createdAt,
    required this.month,
    required this.year,
    required this.isExcelDownloaded,
    required this.isPdfDownloaded,
    required this.isAdmin,
    required this.totalAmount,
    required this.invoiceNo,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.placeOfSupply,
    this.billingCycle,
  });
}

class TaxInvoiceResponseEntity {
  final int totalCount;
  final List<TaxInvoiceEntity> invoices;

  TaxInvoiceResponseEntity({
    required this.totalCount,
    required this.invoices,
  });
}
