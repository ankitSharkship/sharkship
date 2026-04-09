import '../../domain/entities/line_item_entity.dart';

class LineItemModel extends LineItemEntity {
  LineItemModel({
    required super.id,
    required super.grams,
    required super.name,
    required super.price,
    required super.quantity,
    super.sku,
    required super.productCategory,
    required super.productLength,
    required super.productWidth,
    required super.productHeight,
    super.taxRate,
  });

  factory LineItemModel.fromJson(Map<String, dynamic> json) {
    return LineItemModel(
      id: json['id'] ?? 0,
      grams: json['grams']?.toString() ?? '0.0',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      sku: json['sku'],
      productCategory: json['product_category'] ?? '',
      productLength: json['product_length'] ?? 0,
      productWidth: json['product_width'] ?? 0,
      productHeight: json['product_height'] ?? 0,
      taxRate: json['tax_rate']?.toString(),
    );
  }
}
