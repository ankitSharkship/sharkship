import 'package:dio/dio.dart';
import 'package:sharkship/core/network/api_exception.dart';
import 'package:sharkship/features/kyc/data/datasources/kyc_remote_datasource.dart';
import 'package:sharkship/features/kyc/data/model/aadhaar_response_model.dart';

class KycRemoteDataSourceImpl implements KycRemoteDataSource {
  final Dio dio;

  KycRemoteDataSourceImpl(this.dio);

  // ---------- COMMON ERROR HANDLER ----------
  void _handleError(DioException e) {
    final data = e.response?.data;

    throw ApiException(
      message: data?['message'] ?? 'Something went wrong',
      statusCode: e.response?.statusCode,
    );
  }

  // ---------- PAN ----------
  @override
  Future<void> verifyPan(String pan) async {
    try {
      await dio.post(
        '/v1/user/kyc/verify',
        data: {
          "step": "pan",
          "data": {"pan_number": pan}
        },
      );
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  // ---------- BANK ----------
  @override
  Future<void> verifyBank({
    required String ifsc,
    required String accountNumber,
    required String accountType,
    required String accountHolderName,
  }) async {
    try {
      await dio.post(
        '/v1/user/kyc/verify',
        data: {
          "step": "bank",
          "data": {
            "ifsc": ifsc,
            "account_number": accountNumber,
            "account_type": accountType,
            "account_holder_name": accountHolderName,
          }
        },
      );
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  // ---------- GST ----------
  @override
  Future<void> verifyGst(String gst) async {
    try {
      await dio.post(
        '/v1/user/kyc/gst',
        data: {"gst_number": gst},
      );
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  // ---------- AADHAAR ----------
  @override
  Future<AadhaarResponseModel> uploadAadhaar({
    required String frontPath,
    required String backPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'front': await MultipartFile.fromFile(frontPath),
        'back': await MultipartFile.fromFile(backPath),
      });

      final res = await dio.post(
        '/v1/user/aadhar-upload',
        data: formData,
        options: Options(headers: {
          "category": "PERSONAL",
        }),
      );

      return AadhaarResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }
}