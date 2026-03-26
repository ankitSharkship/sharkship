import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/network/api_exception.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:sharkship/features/kyc/domain/usecases/verify_pan_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/upload_aadhar_usecase.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_provider.dart';
import 'kyc_state.dart';

// This line is required for code generation
part 'kyc_notifier.g.dart';

@riverpod
class KycNotifier extends _$KycNotifier {
  // The build method replaces the constructor and defines initial state
  @override
  KycState build() {
    return KycState(kyc: const Kyc(), currentStep: KycStep.aadhaar);
  }

  // --- Helpers to get dependencies ---
  // In Clean Architecture, these would be their own providers
  KycRepository get _repo => ref.read(kycRepositoryProvider);
  VerifyPanUseCase get _verifyPan => ref.read(verifyPanUseCaseProvider);
  UploadAadharUsecase get _uploadAadhaar => ref.read(uploadAadharUseCaseProvider);

  // ---------- Aadhaar ----------
  Future<void> uploadAadhaar(String front, String back) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _uploadAadhaar(front, back);

      state = state.copyWith(
        isLoading: false,
        kyc: state.kyc.copyWith(
          aadhaar: AadhaarData(
            frontImage: front,
            backImage: back,
            isVerified: true,
          ),
        ),
        currentStep: KycStep.pan,
      );
    } catch (e) {
      final message = e is ApiException ? e.message : "Aadhaar upload failed";
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  // ---------- PAN ----------
  Future<void> verifyPanNumber(String pan) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _verifyPan(pan);

      state = state.copyWith(
        isLoading: false,
        kyc: state.kyc.copyWith(pan: PanData(panNumber: pan, isVerified: true)),
        currentStep: KycStep.bank,
      );
    } catch (e) {
      final message = e is ApiException ? e.message : "Something went wrong";
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  // ---------- BANK ----------
  Future<void> verifyBank(BankData bank) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final ok = await _repo.verifyBank(bank);

      if (!ok) {
        state = state.copyWith(
          isLoading: false,
          error: "Bank verification failed",
        );
        return;
      }

      state = state.copyWith(
        isLoading: false,
        kyc: state.kyc.copyWith(bank: bank),
        currentStep: KycStep.gst,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "Service Unavailable");
    }
  }

  // ---------- GST ----------
  Future<void> verifyGst(String gst, bool isBusiness, String gstImage) async {
    state = state.copyWith(isLoading: true, error: null);

    if (!isBusiness) {
      state = state.copyWith(isLoading: false, currentStep: KycStep.review);
      return;
    }

    try {
      final ok = await _repo.verifyGst(gst, gstImage);

      if (!ok) {
        state = state.copyWith(isLoading: false, error: "Invalid GST");
        return;
      }

      state = state.copyWith(
        isLoading: false,
        kyc: state.kyc.copyWith(gst: GstData(gstNumber: gst, isVerified: true)),
        currentStep: KycStep.review,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "GST Verification failed",
      );
    }
  }

  // ---------- FINAL ----------
  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.submitKyc(state.kyc);
      state = state.copyWith(isLoading: false, currentStep: KycStep.submitted);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Final submission failed",
      );
    }
  }

  
}
