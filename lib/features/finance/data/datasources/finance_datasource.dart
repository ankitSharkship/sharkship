import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../models/shipping_rate_model.dart';
import '../models/calculator_rate_model.dart';
import '../models/transaction_model.dart';
import '../models/remittance_model.dart';
import '../models/message_metrics_model.dart';
import '../models/message_transaction_model.dart';
import '../models/tax_invoice_model.dart';
import '../models/cn_invoice_model.dart';
import '../models/initiate_invoice_model.dart';

part 'finance_datasource.g.dart';

class FinanceDataSource {
  final Dio _dio;

  FinanceDataSource(this._dio);

  Future<List<ShippingRateModel>> getShippingRates({
    required String serviceType,
  }) async {
    final response = await _dio.get(
      '/v1/user/shipping-rates',
      queryParameters: {'service_type': serviceType},
    );

    final List<dynamic> data = response.data;
    return data.map((json) => ShippingRateModel.fromJson(json)).toList();
  }

  Future<List<CalculatorRateModel>> calculateShippingRate({
    required String source,
    required String destination,
    required String paymentType,
    required double weight,
    required double productValue,
    required double length,
    required double width,
    required double height,
    required String serviceType,
    required String provider,
  }) async {
    final response = await _dio.get(
      '/v1/calculator/shipping-rate',
      queryParameters: {
        'source': source,
        'destination': destination,
        'payment_type': paymentType,
        'weight': weight,
        'productValue': productValue,
      },
      options: Options(
        headers: {
          'length': length,
          'width': width,
          'height': height,
          'service_type': serviceType,
          'provider': provider,
        },
      ),
    );

    final List<dynamic> ratesData = response.data['rates'] as List<dynamic>;
    return ratesData
        .map(
          (json) => CalculatorRateModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<TransactionResponseModel> getTransactions({
    int total = 10,
    int skip = 0,
    String? transactionType,
    String? affectedBalance,
    String? transactionCategory,
    String? startDate,
    String? endDate,
    String? isWallet,
    String? paymentGateway,
    String? journeyType,
    String? orderId,
    String? trackingId,
    String? paymentGatewayId,
  }) async {
    try {
      final response = await _dio.get(
        '/v1/finance/transactions',
        queryParameters: {
          'total': total,
          'skip': skip,
          'transactionType': transactionType,
          'affectedBalance': affectedBalance,
          'transactionCategory': transactionCategory,
          'startDate': startDate,
          'endDate': endDate,
          'isWallet': isWallet,
          'payment_gateway': paymentGateway,
          'journey_type': journeyType,
          if (trackingId != "" && trackingId != null) 'tracking_id': trackingId,
          if (orderId != "" && orderId != null) 'orderId': orderId,
          if (paymentGatewayId != "" && paymentGatewayId != null)
            'payment_gateway_id': paymentGatewayId,
        },
      );

      return TransactionResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 &&
          e.response?.data["errorCode"] == "FIN-0003") {
        return TransactionResponseModel.fromJson({
          "totalCount": 0,
          "transactions": [],
        });
      }
      rethrow;
    }
  }

  Future<MessageMetricsModel> getMessageMetrics({
    required String startDate,
    required String endDate,
  }) async {
    final response = await _dio.get(
      '/v1/user/message-metrics',
      queryParameters: {'startDate': startDate, 'endDate': endDate},
    );

    return MessageMetricsModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<MessageTransactionsResponseModel> getMessageTransactions({
    required int take,
    required int skip,
    required String startDate,
    required String endDate,
  }) async {
    final response = await _dio.get(
      '/v1/finance/message-transactions',
      queryParameters: {
        'take': take,
        'skip': skip,
        'startDate': startDate,
        'endDate': endDate,
      },
    );

    return MessageTransactionsResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<Map<String, dynamic>> getRemittanceDetails() async {
    final response = await _dio.get('/v1/finance/remittance');
    return response.data as Map<String, dynamic>;
  }

  Future<RemittanceCycleResponseModel> getRemittanceCycles({
    required int total,
    required int skip,
    required String startDate,
    required String endDate,
    String? status,
    String? businessName,
    String? remittanceId,
    String? userId,
    String? phone,
  }) async {
    final response = await _dio.get(
      '/v1/finance/remittance-Cycle',
      queryParameters: {
        'total': total,
        'skip': skip,
        'startDate': startDate,
        'endDate': endDate,
        if (status != null && status.isNotEmpty && status != 'All')
          'status': status,
        if (businessName != null) 'business_name': businessName,
        if (remittanceId != null) 'remittanceId': remittanceId,
        if (userId != null) 'userId': userId,
        if (phone != null) 'phone': phone,
      },
    );
    return RemittanceCycleResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<TaxInvoiceResponseModel> getTaxInvoices({
    required int total,
    required int skip,
    required String startDate,
    required String endDate,
  }) async {
    final response = await _dio.get(
      '/v1/finance/tax-invoice',
      queryParameters: {
        'total': total,
        'skip': skip,
        'startDate': startDate,
        'endDate': endDate,
      },
    );
    return TaxInvoiceResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<CnInvoiceResponseModel> getCnInvoices({
    required int total,
    required int skip,
    required String cnStartDate,
    required String cnEndDate,
    String? cnDateRangeStart,
    String? cnDateRangeEnd,
    String? state,
    String? invoiceNo,
  }) async {
    final response = await _dio.get(
      '/v1/finance/cn-invoice',
      queryParameters: {
        'total': total,
        'skip': skip,
        'cn_start_date': cnStartDate,
        'cn_end_date': cnEndDate,
        if (cnDateRangeStart != null) 'cn_date_range_start': cnDateRangeStart,
        if (cnDateRangeEnd != null) 'cn_date_range_end': cnDateRangeEnd,
        if (state != null) 'state': state,
        if (invoiceNo != null) 'invoice_no': invoiceNo,
      },
    );
    return CnInvoiceResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<InitiateInvoiceModel> initiateInvoice() async {
    final response = await _dio.post('/v1/document/invoice/initiate');
    return InitiateInvoiceModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> verifySingle(Map<String, dynamic> data) async {
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

      final String timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final String fileExt = data['fileType'] ?? 'pdf';
      final String filePath = '${directory!.path}/Invoice_$timestamp.$fileExt';

      final response = await _dio.post(
        '/v1/document/invoice/verify-single',
        data: data,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final File file = File(filePath);
      await file.writeAsBytes(response.data);
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        print("Could not open file: ${result.message}");
      }
    } catch (e) {
      print('Download Invoice Error: $e');
      rethrow;
    }
  }

  Future<void> verifyBulk(Map<String, dynamic> data) async {
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

      final String timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final String filePath = '${directory!.path}/Invoices_Bulk_$timestamp.zip';

      final response = await _dio.post(
        '/v1/document/invoice/verify-bulk',
        data: data,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final File file = File(filePath);
      await file.writeAsBytes(response.data);
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        print("Could not open file: ${result.message}");
      }
    } catch (e) {
      print('Download Bulk Invoice Error: $e');
      rethrow;
    }
  }
}

@riverpod
FinanceDataSource financeDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return FinanceDataSource(dio);
}
