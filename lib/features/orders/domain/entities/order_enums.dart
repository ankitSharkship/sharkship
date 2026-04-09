enum OrderChannel {
  MANUAL,
  SHOPIFY,
  EASYECOM,
  WOOCOMMERCE,
  OPENCART,
  WIX;

  String get name => toString().split('.').last;
}

enum PaymentType {
  COD,
  PREPAID,
  PARTIAL_COD;

  String get name => toString().split('.').last;
}

enum OrderStatus {
  CANCELLED,
  DISPUTED,
  TO_BE_PROCESSED,
  PROCESSED,
  SHIPPED,
  DELIVERED,
  OUT_FOR_DELIVERY,
  NOT_DELIVERED,
  RETURNED,
  NDR,
  RE_ATTEMPTED,
  LOST,
  PROCESSING,
  DELETED,
  ALL,
  ALERT,
  SHOPIFY;

  String get name => toString().split('.').last;
}
