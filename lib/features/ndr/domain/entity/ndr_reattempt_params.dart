class NdrReattemptParams {
  final List<String> orderIds;
  final String updatedDeliveryDate;

  NdrReattemptParams({
    required this.orderIds,
    required this.updatedDeliveryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_ids': orderIds,
      'updated_delivery_date': updatedDeliveryDate,
    };
  }
}
