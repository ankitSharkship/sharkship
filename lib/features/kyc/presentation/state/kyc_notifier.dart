import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/network/api_exception.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:sharkship/features/kyc/domain/usecases/verify_pan_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/upload_aadhar_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/get_kyc_details_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/init_digilocker_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/get_digilocker_status_usecase.dart';
import 'package:sharkship/features/kyc/domain/entities/digilocker_init.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_provider.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';
import 'package:sharkship/features/tickets/presentation/state/ticket_provider.dart';
import 'kyc_state.dart';

// This line is required for code generation
part 'kyc_notifier.g.dart';

@riverpod
class KycNotifier extends _$KycNotifier {
  // The build method replaces the constructor and defines initial state
  @override
  KycState build() {
    // Initial fetch to see where the user is in the KYC flow
    Future.microtask(() => fetchKycStatus());
    return KycState(kyc: const Kyc(), currentStep: KycStep.aadhaar);
  }

  // --- Helpers to get dependencies ---
  // In Clean Architecture, these would be their own providers
  KycRepository get _repo => ref.read(kycRepositoryProvider);
  VerifyPanUseCase get _verifyPan => ref.read(verifyPanUseCaseProvider);
  UploadAadharUsecase get _uploadAadhaar =>
      ref.read(uploadAadharUseCaseProvider);
  GetKycDetailsUseCase get _getKycDetails =>
      ref.read(getKycDetailsUseCaseProvider);
  InitDigilockerUseCase get _initDigilocker =>
      ref.read(initDigilockerUseCaseProvider);
  GetDigilockerStatusUseCase get _getDigilockerStatus =>
      ref.read(getDigilockerStatusUseCaseProvider);

  void previousStep() {
    final steps = KycStep.values;
    final currentIndex = state.currentStep.index;
    if (currentIndex <= 0) return;

    var prevStep = steps[currentIndex - 1];

    // Skip Aadhaar going backwards if not sole-proprietor
    if (prevStep == KycStep.aadhaar && !state.kyc.requiresAadhaar) {
      // There's nothing before aadhaar, so just stay where we are
      return;
    }

    state = state.copyWith(currentStep: prevStep);
  }

  void nextStep() {
    print('Next step');
    print('++++++++++++++++++++');
    final steps = KycStep.values;
    final currentIndex = state.currentStep.index;

    if (state.currentStep == KycStep.submitted) return;
    var nextStep;
    if (state.currentStep == KycStep.bank &&
        state.kyc.entityType == "SOLE_PROPRIETORSHIP") {
      nextStep = steps[currentIndex + 2];
    } else {
      nextStep = steps[currentIndex + 1];
    }

    state = state.copyWith(currentStep: nextStep);
  }

  void moveToGst() {
    state = state.copyWith(currentStep: KycStep.gst);
  }

  void updatePan(String pan) {
    state = state.copyWith(
      kyc: state.kyc.copyWith(pan: PanData(panNumber: pan)),
    );
  }

  void updatePanData(PanData pan) {
    state = state.copyWith(kyc: state.kyc.copyWith(pan: pan));
  }

  void updateBank(BankData bank) {
    state = state.copyWith(kyc: state.kyc.copyWith(bank: bank));
  }

  void updateGst(GstData gst) {
    state = state.copyWith(kyc: state.kyc.copyWith(gst: gst));
  }

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

  Future<DigilockerInitEntity?> startDigilockerKyc() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await _initDigilocker();
      state = state.copyWith(isLoading: false);
      return res;
    } catch (e) {
      final message = e is ApiException
          ? e.message
          : "Aadhaar verification failed";
      state = state.copyWith(isLoading: false, error: message);
      return null;
    }
  }

  Future<void> completeDigilockerKyc(String verificationId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await _getDigilockerStatus(verificationId);
      if (res.isSuccess) {
        await fetchKycStatus();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: "Verification failed. Please try again.",
        );
      }
    } catch (e) {
      // Still fetch status — webhook might have updated DB
      await fetchKycStatus();
    }
  }

  void handleDigilockerFailure() {
    state = state.copyWith(
      isLoading: false,
      error: "Aadhaar verification failed. Please try again.",
    );
  }

  // ---------- PAN ----------
  Future<void> verifyPanNumber() async {
    final pan = state.kyc.pan?.panNumber ?? "";
    if (pan.isEmpty) {
      state = state.copyWith(error: "Please enter PAN number");
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await _verifyPan(pan);
      await fetchKycStatus();
      final finalPan = new PanData(panNumber: pan, isVerified: true);
      updatePanData(finalPan);
    } catch (e) {
      final message = e is ApiException ? e.message : "PAN verification failed";
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  // ---------- BANK ----------
  Future<void> verifyBank() async {
    final bank = state.kyc.bank;
    if (bank == null || bank.accountNumber.isEmpty) {
      state = state.copyWith(error: "Please enter bank details");
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await _repo.verifyBank(bank);
      await fetchKycStatus();
      final finalBank = new BankData(
        accountHolderName: bank.accountHolderName,
        ifscCode: bank.ifscCode,
        accountNumber: bank.accountNumber,
        accountType: bank.accountType,
        isVerified: true,
      );
      updateBank(finalBank);
    } catch (e) {
      final message = e is ApiException
          ? e.message
          : "Bank verification failed";
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  Future<void> verifyGst() async {
    //  final String gst = "";
    //  bool isBusiness, String gstImage
    final gst = state.kyc.gst?.gstNumber ?? "";
    final isBusiness = gst.isNotEmpty;
    final gstImage = state.kyc.gst?.gstImage ?? "";
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

  // ---------- REVIEW ----------
  void confirmReview() async {
    state = state.copyWith(currentStep: KycStep.submitted);
    try {
      await fetchKycStatus();
    } catch (e) {
      final message = e is ApiException ? e.message : "Submission failed";
      state = state.copyWith(isLoading: false, error: message);
    }
  }

  void toggleTerms(bool agreed) {
    state = state.copyWith(isTermsAccepted: agreed);
  }

  // ---------- TERMS ----------
  Future<void> acceptTerms() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.acceptKycDocuments();
      await fetchKycStatus();
    } catch (e) {
      final message = e is ApiException ? e.message : "Submission failed";
      state = state.copyWith(isLoading: false, error: message);
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

  Future<void> getTerms() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // state = state.copyWith(isLoading: false, kyc: );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to Load Terms & Conditions",
      );
    }
  }

  // ---------- FETCH STATUS ----------
  Future<void> fetchKycStatus() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final details = await _getKycDetails();

      KycStep nextStep = KycStep.aadhaar;
      final isRejected = details.kycTicketStatus == "REJECTED";
      print(details.agreementAccepted);
      print('_________+++++++++++++++++++++++++++++++++++++++++');
      final updatedKyc = state.kyc.copyWith(
        aadhaar: details.isAadhaarComplete
            ? AadhaarData(
                frontImage: details.aadharFrontUrl,
                backImage: details.aadharBackUrl,
                aadharName: details.aadharName,
                aadharNumber: details.aadharNumber,
                aadharProfileImage: details.aadharProfileImage,
                isVerified:
                    (details.aadharName != null ||
                        details.aadharFrontUrl != null)
                    ? true
                    : false,
                isRejected: isRejected,
              )
            : state.kyc.aadhaar,
        pan: details.isPanComplete
            ? PanData(
                panNumber: details.pan ?? "",
                isVerified: details.pan != null ? true : false,
              )
            : state.kyc.pan,
        bank: details.isBankComplete
            ? BankData(
                accountHolderName: details.accountHolderName ?? "",
                accountNumber: details.accountNumber ?? "",
                ifscCode: details.ifsc ?? "",
                accountType: details.accountType ?? "",
                isVerified: details.accountHolderName != null ? true : false,
              )
            : state.kyc.bank,
        gst: details.isGstComplete
            ? GstData(
                gstNumber: details.gstNumber ?? "",
                isVerified: details.gstNumber != null ? true : false,
              )
            : state.kyc.gst,
        status: details.status ?? state.kyc.status,
        agreementAccepted:
            details.agreementAccepted ?? state.kyc.agreementAccepted,
        entityType: details.entityType ?? state.kyc.entityType,
      );

      // Transition Logic based on KycStep string from backend
      final backendStep = details.kycStep ?? "INITIATED";
      final isSoleProprietor = updatedKyc.requiresAadhaar;

      if (details.kycTicketStatus == "PENDING") {
        nextStep = KycStep.submitted;
      } else if (details.kycTicketStatus == "RESOLVED") {
        if (details.agreementAccepted != null &&
            details.agreementAccepted == true) {
          nextStep = KycStep.submitted;
        } else {
          nextStep = KycStep.terms;
        }
      } else if (details.kycTicketStatus == "REJECTED") {
      } else {
        // Detailed mapping based on kycStep
        switch (backendStep) {
          case 'INITIATED':
            nextStep = isSoleProprietor ? KycStep.aadhaar : KycStep.pan;
            break;
          case 'aadharUrl':
          case 'aadharVerification':
            nextStep = KycStep.aadhaar;
            break;
          case 'aadhaarDetails':
          case 'udyamVerification':
            nextStep = KycStep.pan;
            break;
          case 'pan':
            nextStep = KycStep.bank;
            break;
          case 'bank':
            nextStep = isSoleProprietor ? KycStep.review : KycStep.gst;
            break;
          case 'gst':
          case 'gstPdf':
          case 'rejected':
            nextStep = KycStep.review;
            break;
          default:
            nextStep = KycStep.aadhaar;
        }
      }

      state = state.copyWith(
        isLoading: false,
        kyc: updatedKyc.copyWith(isSubmitted: details.status != "INITIATED"),
        currentStep: nextStep,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}
