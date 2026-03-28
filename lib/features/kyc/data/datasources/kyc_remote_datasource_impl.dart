import 'package:dio/dio.dart';
import 'package:sharkship/core/network/api_exception.dart';
import 'package:sharkship/features/kyc/data/datasources/kyc_remote_datasource.dart';
import 'package:sharkship/features/kyc/data/model/aadhaar_response_model.dart';
import 'package:sharkship/features/kyc/data/model/digilocker_models.dart';
import 'package:sharkship/features/kyc/data/model/kyc_response_model.dart';

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
          "data": {"pan_number": pan},
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
          },
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
      await dio.post('/v1/user/kyc/gst', data: {"gst_number": gst});
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
        options: Options(headers: {"category": "PERSONAL"}),
      );

      return AadhaarResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<void> acceptKycDocuments() async {
    try {
      await dio.post('/v1/user/kyc/documentAccept', data: {});
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<KycResponseModel> fetchKycDetails() async {
    try {
      final res = await dio.get('/v1/user/kyc');
      return KycResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<DigilockerInitModel> initDigilocker() async {
    try {
      final res = await dio.post(
        '/v1/user/kyc/verify',
        data: {"step": "aadharUrl"},
      );
      return DigilockerInitModel.fromJson(res.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<void> submitKyc() async {
    try {
      final res = await dio.post(
        '/v1/support/ticket',
        data: {"category": 'KYC', "user_note": 'Please verify my KYC details!'},
      );
      return ;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<DigilockerStatusModel> getDigilockerStatus(
    String verificationId,
  ) async {
    try {
      final res = await dio.post(
        '/v1/user/kyc/verify',
        data: {
          "step": "aadharVerification",
          "data": {"verification_id": verificationId},
        },
      );
      // If we reach here, the first call succeeded.
      final firstModel = DigilockerStatusModel.fromJson(res.data);

      // 2. Second Call: Trigger based on success
      // Example: Update user profile with the name/DOB received
      if (firstModel.status == "AUTHENTICATED") {
        final newRes = await dio.post(
          '/v1/user/kyc/verify',
          data: {
            "step": "aadhaarDetails",
            "data": {"verification_id": verificationId},
          },
        );
        return DigilockerStatusModel.fromJson(newRes.data);
      }

      return firstModel;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }
}
