import 'dart:io';

import 'package:dio/dio.dart';
import '../../domain/repositories/orders_repository.dart';
import '../models/orders_response_model.dart';
import '../models/order_address_model.dart';
import '../models/courier_rate_model.dart';
import '../models/courier_priority_model.dart';
import '../models/courier_partner_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:excel/excel.dart';

class OrdersDataSource {
  final Dio _dio;

  OrdersDataSource(this._dio);

  Future<OrdersResponseModel> getOrders(OrderListParams params) async {
    final response = await _dio.get(
      'v1/order/list',
      queryParameters: params.toJson(),
    );
    return OrdersResponseModel.fromJson(response.data);
  }

  Future<List<OrderAddressModel>> getPickupAddresses() async {
    final response = await _dio.get('v1/address/pickupAddress');
    return (response.data as List)
        .map((e) => OrderAddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<bool> patchDefaultPickupAddress(int id) async {
    final response = await _dio.patch('v1/address/pickupAddress/default/$id');
    return response.statusCode == 200 || response.statusCode == 204;
  }

  Future<ShippingRateResponseModel> getShippingRates(
    ShippingRateParams params,
  ) async {
    final response = await _dio.get(
      'v1/calculator/shipping-rate',
      queryParameters: params.getQueryParameters(),
      options: Options(headers: params.getHeaders()),
    );
    return ShippingRateResponseModel.fromJson(response.data);
  }

  Future<bool> createOrder(CreateOrderParams params) async {
    final response = await _dio.post('v1/order/create', data: params.toJson());
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<void> downloadTemplate() async {
    try {
      Directory? directory;
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getExternalStorageDirectory();
      }
      final String filePath = '${directory!.path}/template.xlsx';
      final response = await _dio.get(
        'v1/document/bulkImportTemplate',
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final File file = File(filePath);
      await file.writeAsBytes(response.data);
      print("File downloaded to: $filePath");

      final result = await OpenFile.open(filePath);
      print(result);
      if (result.type != ResultType.done) {
        print("Could not open file: ${result.message}");
      }
    } catch (e) {
      print('Download Error: $e');
    }
  }

  dynamic _parseCell(Data? cell) {
    if (cell == null) return null;

    final value = cell.value;
    if (value == null) return null;

    if (value is TextCellValue) {
      final str = value.value?.toString().trim();
      return (str == null || str.isEmpty) ? null : str;
    }

    if (value is IntCellValue) return value.value;
    if (value is DoubleCellValue) return value.value;
    if (value is BoolCellValue) return value.value;

    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }

  Future<bool> handleBulkUpload(File file) async {
    try {
      final bytes = file.readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);

      if (excel.tables.isEmpty) return false;

      final table = excel.tables[excel.tables.keys.first]!;
      final rows = table.rows;
      if (rows.length < 2) return false;

      // Extract headers
      final headers = rows.first
          .map((cell) => cell?.value?.toString().toUpperCase() ?? "")
          .toList();

      List<Map<String, dynamic>> ordersPayload = [];

      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];
        Map<String, dynamic> rowData = {};
        for (int j = 0; j < headers.length; j++) {
          if (j < row.length) {
            rowData[headers[j]] = _parseCell(row[j]);
          }
        }

        if (rowData["CUSTOMER_NAME"] == null) continue;

        final lineInfo = _createLineItemsAndCalculateTotal(rowData);
        final List<Map<String, dynamic>> lineItems =
            List<Map<String, dynamic>>.from(lineInfo["lineItems"]);
        final double totalShipmentPrice = lineInfo["totalShipmentPrice"];
        print(lineItems);
        print(lineItems[0]);
        ordersPayload.add({
          "product_name": lineItems.isNotEmpty
              ? lineItems[0]["product_name"]
              : "",
          "product_price": totalShipmentPrice,
          "cod_amount":
              double.tryParse(rowData["COD_AMOUNT"]?.toString() ?? "0") ?? 0,
          "product_quantity": 1,
          "product_category": lineItems.isNotEmpty
              ? lineItems[0]["product_category"]
              : "",
          "product_sku_no": lineItems.isNotEmpty
              ? lineItems[0]["product_sku_no"]
              : null,
          "payment_mode":
              rowData["PAYMENT_MODE"]?.toString().toUpperCase() ?? "PREPAID",
          "client_orderId": rowData["CLIENT_ORDER_ID"]?.toString() ?? null,
          "channel_order_id": rowData["CHANNEL_ORDER_ID"]?.toString() ?? "0",
          "lineItems": lineItems,
          "customer_name": rowData["CUSTOMER_NAME"]?.toString(),
          "customer_mobile_no": rowData["CUSTOMER_MOBILE_NO"]?.toString(),
          "customer_email": rowData["CUSTOMER_EMAIL"]?.toString(),
          "customer_address_lane1": rowData["CUSTOMER_ADDRESS_LANE_1"]
              ?.toString(),
          "customer_address_lane2": rowData["CUSTOMER_ADDRESS_LANE_2"]
              ?.toString(),
          "customer_address_landmark": rowData["CUSTOMER_ADDRESS_LANDMARK"],
          "customer_address_pin": rowData["CUSTOMER_ADDRESS_PIN"],
          "customer_address_city": rowData["CUSTOMER_ADDRESS_CITY"]?.toString(),
          "customer_address_state": rowData["CUSTOMER_ADDRESS_STATE"]
              ?.toString(),
          "pickup_address_id": rowData["PICKUP_ADDRESS_ID"]?.toString(),
          "shipment_weight":
              double.tryParse(rowData["SHIPMENT_WEIGHT"]?.toString() ?? "0") ??
              0,
          "shipment_length":
              double.tryParse(rowData["SHIPMENT_LENGTH"]?.toString() ?? "0") ??
              0,
          "shipment_widht":
              double.tryParse(rowData["SHIPMENT_WIDTH"]?.toString() ?? "0") ??
              0,
          "shipment_height":
              double.tryParse(rowData["SHIPMENT_HEIGHT"]?.toString() ?? "0") ??
              0,
        });
      }
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
      print(ordersPayload);
      print('Reached here');
      if (ordersPayload.isEmpty) return false;
      print('Loast here');
      final response = await _dio.post(
        'v1/order/create/bulk',
        data: ordersPayload,
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500 && e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          final List<dynamic> failedOrders = data['data'];
          await _saveErrorBatchToExcel(failedOrders);
        }
      }
      print('Upload Error: $e');
      return false;
    } catch (e) {
      print('Upload Error: $e');
      return false;
    }
  }

  Future<void> _saveErrorBatchToExcel(List<dynamic> failedOrders) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      // Define Headers
      List<String> headers = [
        "CUSTOMER_NAME",
        "COD_AMOUNT",
        "PAYMENT_MODE",
        "CLIENT_ORDER_ID",
        "CHANNEL_ORDER_ID",
        "CUSTOMER_MOBILE_NO",
        "CUSTOMER_EMAIL",
        "CUSTOMER_ADDRESS_LANE_1",
        "CUSTOMER_ADDRESS_LANE_2",
        "CUSTOMER_ADDRESS_LANDMARK",
        "CUSTOMER_ADDRESS_PIN",
        "CUSTOMER_ADDRESS_CITY",
        "CUSTOMER_ADDRESS_STATE",
        "PICKUP_ADDRESS_ID",
        "SHIPMENT_WEIGHT",
        "SHIPMENT_LENGTH",
        "SHIPMENT_WIDTH",
        "SHIPMENT_HEIGHT",
      ];

      // Find max line items to add corresponding headers
      int maxLineItems = 0;
      for (var order in failedOrders) {
        if (order is Map<String, dynamic> && order.containsKey('lineItems')) {
          final List<dynamic> items = order['lineItems'];
          if (items.length > maxLineItems) maxLineItems = items.length;
        }
      }

      for (int i = 1; i <= maxLineItems; i++) {
        headers.addAll([
          "PRODUCT_NAME_$i",
          "PRODUCT_PRICE_$i",
          "PRODUCT_QUANTITY_$i",
          "PRODUCT_SKU_NO_$i",
          "PRODUCT_CATEGORY_$i",
        ]);
      }
      headers.add("ERROR");

      // Set headers in Excel
      sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

      // Add Data Rows
      for (var order in failedOrders) {
        if (order is! Map<String, dynamic>) continue;

        List<CellValue?> rowValues = [];
        // Map basic fields
        rowValues.add(TextCellValue(order['customer_name']?.toString() ?? ""));
        rowValues.add(
          DoubleCellValue(
            double.tryParse(order['cod_amount']?.toString() ?? "0") ?? 0,
          ),
        );
        rowValues.add(TextCellValue(order['payment_mode']?.toString() ?? ""));
        rowValues.add(TextCellValue(order['client_orderId']?.toString() ?? ""));
        rowValues.add(
          TextCellValue(order['channel_order_id']?.toString() ?? ""),
        );
        rowValues.add(
          TextCellValue(order['customer_mobile_no']?.toString() ?? ""),
        );
        rowValues.add(TextCellValue(order['customer_email']?.toString() ?? ""));
        rowValues.add(
          TextCellValue(order['customer_address_lane1']?.toString() ?? ""),
        );
        rowValues.add(
          TextCellValue(order['customer_address_lane2']?.toString() ?? ""),
        );
        rowValues.add(
          TextCellValue(order['customer_address_landmark']?.toString() ?? ""),
        );
        rowValues.add(
          TextCellValue(order['customer_address_pin']?.toString() ?? ""),
        );
        rowValues.add(
          TextCellValue(order['customer_address_city']?.toString() ?? ""),
        );
        rowValues.add(
          TextCellValue(order['customer_address_state']?.toString() ?? ""),
        );
        rowValues.add(
          TextCellValue(order['pickup_address_id']?.toString() ?? ""),
        );
        rowValues.add(
          DoubleCellValue(
            double.tryParse(order['shipment_weight']?.toString() ?? "0") ?? 0,
          ),
        );
        rowValues.add(
          DoubleCellValue(
            double.tryParse(order['shipment_length']?.toString() ?? "0") ?? 0,
          ),
        );
        rowValues.add(
          DoubleCellValue(
            double.tryParse(order['shipment_widht']?.toString() ?? "0") ?? 0,
          ),
        );
        rowValues.add(
          DoubleCellValue(
            double.tryParse(order['shipment_height']?.toString() ?? "0") ?? 0,
          ),
        );

        // Add line items
        final List<dynamic> items = order['lineItems'] ?? [];
        for (int i = 0; i < maxLineItems; i++) {
          if (i < items.length) {
            final item = items[i];
            rowValues.addAll([
              TextCellValue(item['product_name']?.toString() ?? ""),
              DoubleCellValue(
                double.tryParse(item['product_price']?.toString() ?? "0") ?? 0,
              ),
              IntCellValue(
                int.tryParse(item['product_quantity']?.toString() ?? "0") ?? 0,
              ),
              TextCellValue(item['product_sku_no']?.toString() ?? ""),
              TextCellValue(item['product_category']?.toString() ?? ""),
            ]);
          } else {
            rowValues.addAll(List.filled(5, null));
          }
        }

        rowValues.add(TextCellValue(order['error']?.toString() ?? ""));
        sheetObject.appendRow(rowValues);
      }

      // Save File
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      final String timestamp = DateTime.now().toIso8601String().replaceAll(
        ':',
        '-',
      );
      final String filePath =
          '${directory!.path}/Unprocessed_bulk_orders_$timestamp.xlsx';

      final List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        print("Error file saved to: $filePath");
        await OpenFile.open(filePath);
      }
    } catch (e) {
      print("Error saving error batch to Excel: $e");
    }
  }

  Map<String, dynamic> _createLineItemsAndCalculateTotal(
    Map<String, dynamic> orderData,
  ) {
    List<Map<String, dynamic>> lineItems = [];
    double totalShipmentPrice = 0;
    int i = 1;
    while (true) {
      String productNameKey = "PRODUCT_NAME_$i";
      if (!orderData.containsKey(productNameKey) ||
          orderData[productNameKey] == null) {
        break;
      }
      String name = orderData[productNameKey].toString();
      String? sku = orderData["PRODUCT_SKU_NO_$i"]?.toString();
      String? category = orderData["PRODUCT_CATEGORY_$i"]?.toString();
      double price =
          double.tryParse(orderData["PRODUCT_PRICE_$i"]?.toString() ?? "0") ??
          0;
      int quantity =
          int.tryParse(orderData["PRODUCT_QUANTITY_$i"]?.toString() ?? "0") ??
          0;

      lineItems.add({
        "product_name": name,
        "product_price": price,
        "product_quantity": quantity,
        "product_sku_no": sku,
        "product_category": category,
      });
      totalShipmentPrice += price * quantity;
      i++;
    }
    return {"lineItems": lineItems, "totalShipmentPrice": totalShipmentPrice};
  }

  Future<Map<String, dynamic>> deleteOrders(
    Map<String, dynamic> orderIds,
  ) async {
    try {
      final response = await _dio.delete('v1/order', data: orderIds);
      return response.data;
    } catch (e) {
      return {"error": "${e.toString()}"};
    }
  }

  Future<Map<String, dynamic>> shipOrders(Map<String, dynamic> orderIds) async {
    try {
      final response = await _dio.put(
        'v1/order',
        data: orderIds,
        options: Options(
          headers: {..._dio.options.headers, 'move_to': "PROCESSED"},
        ),
      );
      return response.data;
    } catch (e) {
      return {"error": "${e.toString()}"};
    }
  }

  Future<CourierPriorityModel> getCourierPriority() async {
    final response = await _dio.get('v1/user/courier-priority');
    return CourierPriorityModel.fromJson(response.data);
  }

  Future<bool> putCourierPriority(Map<String, dynamic> data) async {
    final response = await _dio.put('v1/user/courier-priority', data: data);
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<CourierPartnerModel>> getCourierPartners() async {
    final response = await _dio.get('v1/user/courierPartner');
    return (response.data as List)
        .map((e) => CourierPartnerModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> downloadShippingLabel(List<int> orderIds) async {
    try {
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      final String timestamp = DateTime.now().toIso8601String().replaceAll(
        ':',
        '-',
      );
      final String filePath = '${directory!.path}/Shipping_Label_$timestamp.pdf';

      final response = await _dio.post(
        'v1/document/shipping_label',
        data: {'order_ids': orderIds},
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final File file = File(filePath);
      await file.writeAsBytes(response.data);
      print("Shipping label downloaded to: $filePath");

      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        print("Could not open file: ${result.message}");
      }
    } catch (e) {
      print('Download Label Error: $e');
    }
  }

  Future<void> updateInvoiceConfiguration(Map<String, dynamic> config) async {
    await _dio.put('v1/document/invoice_configuration', data: config);
  }

  Future<void> downloadOrderInvoice(List<int> orderIds) async {
    try {
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      final String timestamp = DateTime.now().toIso8601String().replaceAll(
        ':',
        '-',
      );
      final String filePath = '${directory!.path}/Order_Invoice_$timestamp.pdf';

      final response = await _dio.post(
        'v1/document/order_invoice/bulk',
        data: {'order_ids': orderIds},
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final File file = File(filePath);
      await file.writeAsBytes(response.data);
      print("Order invoice downloaded to: $filePath");

      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        print("Could not open file: ${result.message}");
      }
    } catch (e) {
      print('Download Invoice Error: $e');
      rethrow;
    }
  }

  Future<void> generateManifestation(List<int> orderIds) async {
    try {
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      final String timestamp = DateTime.now().toIso8601String().replaceAll(
        ':',
        '-',
      );
      final String filePath = '${directory!.path}/Manifest_$timestamp.pdf';

      final response = await _dio.post(
        'v1/document/generate_manifestation',
        data: {'order_ids': orderIds},
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final File file = File(filePath);
      await file.writeAsBytes(response.data);
      print("Manifest downloaded to: $filePath");

      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        print("Could not open file: ${result.message}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelOrders(List<int> orderIds) async {
    await _dio.put(
      'v1/order',
      data: {'order_ids': orderIds},
      options: Options(
        headers: {'move_to': 'CANCELLED'},
      ),
    );
  }

  Future<void> cloneOrder(int id) async {
    await _dio.post('v1/order/clone/$id');
  }
}

extension OrdersDataSourceExport on OrdersDataSource {
  Future<void> exportOrders(List<int> orderIds) async {
    final response = await _dio.post(
      'v1/order/export',
      data: {'order_ids': orderIds},
    );
    final List<dynamic> orders = response.data as List;
    await _saveExportedOrdersToExcel(orders);
  }

  Future<void> _saveExportedOrdersToExcel(List<dynamic> orders) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        "Order ID",
        "Client Order ID",
        "Channel Order ID",
        "Store",
        "AWB",
        "Creation Date",
        "Carrier",
        "Courier Type",
        "Channel",
        "Payment Type",
        "Price",
        "Total Price",
        "Product Name",
        "Category",
        "Pickup Lane 1",
        "Pickup Lane 2",
        "Pickup City",
        "Pickup State",
        "Pickup Pin",
        "Quantity",
        "Weight",
        "Status",
        "Whatsapp Remark",
        "Zone",
        "Customer Name",
        "Customer Mobile",
        "Customer Email",
        "Customer Address 1",
        "Customer Address 2",
        "Landmark",
        "Customer Pin",
        "Customer City",
        "Customer State",
        "Last Event",
        "Shipping Charge",
      ];

      // Set headers in Excel
      sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

      // Add Data Rows
      for (var order in orders) {
        if (order is! Map<String, dynamic>) continue;

        sheetObject.appendRow([
          TextCellValue(order['id']?.toString() ?? ""),
          TextCellValue(order['client_orderId']?.toString() ?? ""),
          TextCellValue(order['channel_order_Id']?.toString() ?? ""),
          TextCellValue(order['channel_store']?.toString() ?? ""),
          TextCellValue(order['awb']?.toString() ?? ""),
          TextCellValue(order['creation_Date']?.toString() ?? ""),
          TextCellValue(order['carrier']?.toString() ?? ""),
          TextCellValue(order['courier_type']?.toString() ?? ""),
          TextCellValue(order['channel']?.toString() ?? ""),
          TextCellValue(order['payment_type']?.toString() ?? ""),
          DoubleCellValue(
            double.tryParse(order['price']?.toString() ?? "0") ?? 0,
          ),
          DoubleCellValue(
            double.tryParse(order['total_price']?.toString() ?? "0") ?? 0,
          ),
          TextCellValue(order['product_name']?.toString() ?? ""),
          TextCellValue(order['product_category']?.toString() ?? ""),
          TextCellValue(order['pickup_address_lane1']?.toString() ?? ""),
          TextCellValue(order['pickup_address_lane2']?.toString() ?? ""),
          TextCellValue(order['pickup_city']?.toString() ?? ""),
          TextCellValue(order['pickup_state']?.toString() ?? ""),
          TextCellValue(order['pickup_Pin']?.toString() ?? ""),
          IntCellValue(int.tryParse(order['quantity']?.toString() ?? "0") ?? 0),
          TextCellValue(order['weight']?.toString() ?? ""),
          TextCellValue(order['status']?.toString() ?? ""),
          TextCellValue(order['whatsapp_remark']?.toString() ?? ""),
          TextCellValue(order['zone']?.toString() ?? ""),
          TextCellValue(order['customer_name']?.toString() ?? ""),
          TextCellValue(order['customer_mobile_no']?.toString() ?? ""),
          TextCellValue(order['customer_email']?.toString() ?? ""),
          TextCellValue(order['customer_address_lane1']?.toString() ?? ""),
          TextCellValue(order['customer_address_lane2']?.toString() ?? ""),
          TextCellValue(order['customer_address_landmark']?.toString() ?? ""),
          TextCellValue(order['customer_address_Pin']?.toString() ?? ""),
          TextCellValue(order['customer_address_city']?.toString() ?? ""),
          TextCellValue(order['customer_address_state']?.toString() ?? ""),
          TextCellValue(order['last_event_at']?.toString() ?? ""),
          TextCellValue(order['shipping_charge']?.toString() ?? ""),
        ]);
      }

      // Save File
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      final String timestamp = DateTime.now().toIso8601String().replaceAll(
        ':',
        '-',
      );
      final String filePath =
          '${directory!.path}/Exported_orders_$timestamp.xlsx';

      final List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        print("Exported file saved to: $filePath");
        await OpenFile.open(filePath);
      }
    } catch (e) {
      print("Error saving exported orders to Excel: $e");
    }
  }
}

extension OrdersDataSourceEdit on OrdersDataSource {
  Future<Map<String, dynamic>> editOrder(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await _dio.put('v1/order/edit/$id', data: data);
    return response.data as Map<String, dynamic>;
  }
}
