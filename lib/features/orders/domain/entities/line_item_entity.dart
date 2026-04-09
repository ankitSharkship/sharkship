class LineItemEntity {
  final int id;
  final String grams;
  final String name;
  final num price;
  final int quantity;
  final String? sku;
  final String productCategory;
  final int productLength;
  final int productWidth;
  final int productHeight;
  final String? taxRate;

  LineItemEntity({
    required this.id,
    required this.grams,
    required this.name,
    required this.price,
    required this.quantity,
    this.sku,
    required this.productCategory,
    required this.productLength,
    required this.productWidth,
    required this.productHeight,
    this.taxRate,
  });
}
