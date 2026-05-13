import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/network/api_exception.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:sharkship/features/kyc/domain/usecases/get_terms_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/verify_pan_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/upload_aadhar_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/get_kyc_details_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/init_digilocker_usecase.dart';
import 'package:sharkship/features/kyc/domain/usecases/get_digilocker_status_usecase.dart';
import 'package:sharkship/features/kyc/domain/entities/digilocker_init.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_provider.dart';
import 'kyc_state.dart';

part 'kyc_notifier.g.dart';

@riverpod
class KycNotifier extends _$KycNotifier {
  @override
  Future<KycState> build() => _fetchAndMap();

  // --- Dependencies ---
  KycRepository get _repo => ref.read(kycRepositoryProvider);
  VerifyPanUseCase get _verifyPan => ref.read(verifyPanUseCaseProvider);
  UploadAadharUsecase get _uploadAadhaar =>
      ref.read(uploadAadharUseCaseProvider);
  GetKycDetailsUseCase get _getKycDetails =>
      ref.read(getKycDetailsUseCaseProvider);
  GetTermsUsecase get _getTerms => ref.read(getTermsUsecaseProvider);
  InitDigilockerUseCase get _initDigilocker =>
      ref.read(initDigilockerUseCaseProvider);
  GetDigilockerStatusUseCase get _getDigilockerStatus =>
      ref.read(getDigilockerStatusUseCaseProvider);

  // --- Core fetch + mapping logic (shared by build & fetchKycStatus) ---
  Future<KycState> _fetchAndMap({KycState? current}) async {
    final details = await _getKycDetails();

    final base =
        current ?? KycState(kyc: const Kyc(), currentStep: KycStep.aadhaar);
    final isRejected = details.kycTicketStatus == 'REJECTED';

    final updatedKyc = base.kyc.copyWith(
      aadhaar: details.isAadhaarComplete
          ? AadhaarData(
              frontImage: details.aadharFrontUrl,
              backImage: details.aadharBackUrl,
              aadharName: details.aadharName,
              aadharNumber: details.aadharNumber,
              aadharProfileImage: details.aadharProfileImage,
              isVerified:
                  (details.aadharName != null || details.aadharFrontUrl != null)
                  ? true
                  : false,
              isRejected: isRejected,
            )
          : base.kyc.aadhaar,
      pan: details.isPanComplete
          ? PanData(
              panNumber: details.pan ?? '',
              isVerified: details.pan != null ? true : false,
            )
          : base.kyc.pan,
      bank: details.isBankComplete
          ? BankData(
              accountHolderName: details.accountHolderName ?? '',
              accountNumber: details.accountNumber ?? '',
              ifscCode: details.ifsc ?? '',
              accountType: details.accountType ?? '',
              isVerified: details.accountHolderName != null ? true : false,
            )
          : base.kyc.bank,
      gst: details.isGstComplete
          ? GstData(
              gstNumber: details.gstNumber ?? '',
              isVerified: details.gstNumber != null ? true : false,
            )
          : base.kyc.gst,
      status: details.status ?? base.kyc.status,
      agreementAccepted:
          details.agreementAccepted ?? base.kyc.agreementAccepted,
      entityType: details.entityType ?? base.kyc.entityType,
    );

    final backendStep = details.kycStep ?? 'INITIATED';
    final isSoleProprietor = updatedKyc.requiresAadhaar;
    KycStep nextStep = KycStep.aadhaar;

    if (details.kycTicketStatus == 'PENDING') {
      nextStep = KycStep.submitted;
    } else if (details.kycTicketStatus == 'RESOLVED') {
      if (details.agreementAccepted == true) {
        return base.copyWith(
          kyc: updatedKyc.copyWith(isSubmitted: true),
          shouldNavigateHome: true,
        );
      } else {
        final terms = await _getTerms();
        return base.copyWith(
          kyc: updatedKyc,
          currentStep: KycStep.terms,
          termsHtml: terms,
        );
      }
    } else if (details.kycTicketStatus == 'REJECTED') {
      nextStep = isSoleProprietor ? KycStep.aadhaar : KycStep.pan;
    } else {
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

    return base.copyWith(
      kyc: updatedKyc.copyWith(isSubmitted: details.status != 'INITIATED'),
      currentStep: nextStep,
    );
  }

  // --- Public refresh ---
  Future<void> fetchKycStatus() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchAndMap(current: state.value));
  }

  // --- Sync step navigation (patch inside AsyncValue) ---
  void previousStep() {
    state = state.whenData((s) {
      final steps = KycStep.values;
      final currentIndex = s.currentStep.index;
      if (currentIndex <= 0) return s;
      print(s.currentStep.name);
      print(s.kyc.entityType);
      var prevStep = steps[currentIndex - 1];
      print(prevStep);
      if (prevStep == KycStep.aadhaar && !s.kyc.requiresAadhaar) return s;
      if (s.currentStep.name == KycStep.review.name &&
          s.kyc.entityType == 'SOLE_PROPRIETORSHIP') {
        print('hahahah');
        prevStep = steps[currentIndex - 2];
      } else {
        print("heheheheh");
      }
      return s.copyWith(currentStep: prevStep);
    });
  }

  void nextStep() {
    state = state.whenData((s) {
      final steps = KycStep.values;
      final currentIndex = s.currentStep.index;
      if (s.currentStep == KycStep.submitted) return s;
      final nextStep =
          (s.currentStep == KycStep.bank &&
              s.kyc.entityType == 'SOLE_PROPRIETORSHIP')
          ? steps[currentIndex + 2]
          : steps[currentIndex + 1];
      return s.copyWith(currentStep: nextStep);
    });
  }

  void moveToGst() {
    state = state.whenData((s) => s.copyWith(currentStep: KycStep.gst));
  }

  void updatePan(String pan) {
    state = state.whenData(
      (s) => s.copyWith(
        kyc: s.kyc.copyWith(pan: PanData(panNumber: pan)),
      ),
    );
  }

  void updatePanData(PanData pan) {
    state = state.whenData((s) => s.copyWith(kyc: s.kyc.copyWith(pan: pan)));
  }

  void updateBank(BankData bank) {
    state = state.whenData((s) => s.copyWith(kyc: s.kyc.copyWith(bank: bank)));
  }

  void updateGst(GstData gst) {
    state = state.whenData((s) => s.copyWith(kyc: s.kyc.copyWith(gst: gst)));
  }

  void toggleTerms(bool agreed) {
    state = state.whenData((s) => s.copyWith(isTermsAccepted: agreed));
  }

  void handleDigilockerFailure() {
    // Surface the error via AsyncError so the UI .when() picks it up
    state = AsyncError(
      'Aadhaar verification failed. Please try again.',
      StackTrace.current,
    );
  }

  // --- Aadhaar ---
  Future<void> uploadAadhaar(String front, String back) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final current =
          state.value ??
          KycState(kyc: const Kyc(), currentStep: KycStep.aadhaar);
      final result = await _uploadAadhaar(front, back);
      return current.copyWith(
        kyc: current.kyc.copyWith(
          aadhaar: AadhaarData(
            frontImage: front,
            backImage: back,
            isVerified: result.isValid,
          ),
        ),
        currentStep: KycStep.pan,
      );
    });
  }

  Future<DigilockerInitEntity?> startDigilockerKyc() async {
    state = const AsyncLoading();
    try {
      final res = await _initDigilocker();
      // Restore previous data state so UI doesn't blank out
      state = AsyncData(
        state.value ?? KycState(kyc: const Kyc(), currentStep: KycStep.aadhaar),
      );
      return res;
    } catch (e, st) {
      state = AsyncError(
        e is ApiException ? e.message : 'Aadhaar verification failed',
        st,
      );
      return null;
    }
  }

  Future<void> completeDigilockerKyc(String verificationId) async {
    state = const AsyncLoading();
    try {
      final res = await _getDigilockerStatus(verificationId);
      if (res.isSuccess) {
        await fetchKycStatus();
      } else {
        state = AsyncError(
          'Verification failed. Please try again.',
          StackTrace.current,
        );
      }
    } catch (_) {
      // Webhook may have already updated the DB — attempt a refresh
      await fetchKycStatus();
    }
  }

  // --- PAN ---
  Future<void> verifyPanNumber() async {
    final pan = state.value?.kyc.pan?.panNumber ?? '';
    if (pan.isEmpty) {
      state = AsyncError('Please enter PAN number', StackTrace.current);
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _verifyPan(pan);
      final refreshed = await _fetchAndMap(current: state.value);
      return refreshed.copyWith(
        kyc: refreshed.kyc.copyWith(
          pan: PanData(panNumber: pan, isVerified: true),
        ),
      );
    });
  }

  // --- Bank ---
  Future<void> verifyBank() async {
    final bank = state.value?.kyc.bank;
    if (bank == null || bank.accountNumber.isEmpty) {
      state = AsyncError('Please enter bank details', StackTrace.current);
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.verifyBank(bank);
      final refreshed = await _fetchAndMap(current: state.value);
      return refreshed.copyWith(
        kyc: refreshed.kyc.copyWith(
          bank: BankData(
            accountHolderName: bank.accountHolderName,
            ifscCode: bank.ifscCode,
            accountNumber: bank.accountNumber,
            accountType: bank.accountType,
            isVerified: true,
          ),
        ),
      );
    });
  }

  // --- GST ---
  Future<void> verifyGst() async {
    final current = state.value;
    final gst = current?.kyc.gst?.gstNumber ?? '';
    final isBusiness = gst.isNotEmpty;
    final gstImage = current?.kyc.gst?.gstImage ?? '';

    if (!isBusiness) {
      state = state.whenData((s) => s.copyWith(currentStep: KycStep.review));
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ok = await _repo.verifyGst(gst, gstImage);
      if (!ok) throw Exception('Invalid GST');
      final s = current!;
      return s.copyWith(
        kyc: s.kyc.copyWith(gst: GstData(gstNumber: gst, isVerified: true)),
        currentStep: KycStep.review,
      );
    });
  }

  // --- Terms ---
  Future<void> acceptTerms() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.acceptKycDocuments();
      return await _fetchAndMap(current: state.value);
    });
  }

  // --- Final submit ---
  Future<void> submit() async {
    final kyc = state.value?.kyc;
    if (kyc == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.submitKyc(kyc);
      final current =
          state.value ?? KycState(kyc: kyc, currentStep: KycStep.submitted);
      return current.copyWith(currentStep: KycStep.submitted);
    });
  }

  // --- Review ---
  Future<void> confirmReview() async {
    state = state.whenData((s) => s.copyWith(currentStep: KycStep.submitted));
    await fetchKycStatus();
  }
}
