import 'package:sharkship/features/finance/domain/entities/initiate_invoice_entity.dart';

class InitiateInvoiceModel extends InitiateInvoiceEntity {
  InitiateInvoiceModel({required super.verifyId});

  factory InitiateInvoiceModel.fromJson(Map<String, dynamic> json) {
    return InitiateInvoiceModel(
      verifyId: json['verify_id'] ?? '',
    );
  }
}
