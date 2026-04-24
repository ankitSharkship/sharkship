class CnInvoiceEntity {
  final String id;
  final DateTime createdAt;
  final DateTime cnStartDate;
  final DateTime cnEndDate;
  final DateTime cnDate;
  final bool isExcelDownloaded;
  final bool isPdfDownloaded;
  final String totalAmount;
  final String invoiceNo;
  final String state;
  final String? cgst;
  final String? sgst;
  final String? igst;
  final String? placeOfSupply;

  CnInvoiceEntity({
    required this.id,
    required this.createdAt,
    required this.cnStartDate,
    required this.cnEndDate,
    required this.cnDate,
    required this.isExcelDownloaded,
    required this.isPdfDownloaded,
    required this.totalAmount,
    required this.invoiceNo,
    required this.state,
    this.cgst,
    this.sgst,
    this.igst,
    this.placeOfSupply,
  });
}

class CnInvoiceResponseEntity {
  final int totalCount;
  final List<CnInvoiceEntity> invoices;

  CnInvoiceResponseEntity({
    required this.totalCount,
    required this.invoices,
  });
}
