import 'package:sharkship/features/kyc/domain/entities/kyc.dart';

enum KycStep { aadhaar, pan, bank, gst, review, terms, submitted }
class KycState {
  final Kyc kyc;
  final KycStep currentStep;
  final bool isLoading;
  final String? error;
  final bool isTermsAccepted;

  KycState({
    required this.kyc,
    required this.currentStep,
    this.isLoading = false,
    this.error,
    this.isTermsAccepted = false,
  });

  KycState copyWith({
    Kyc? kyc,
    KycStep? currentStep,
    bool? isLoading,
    String? error,
    bool? isTermsAccepted,
  }) {
    return KycState(
      kyc: kyc ?? this.kyc,
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
    );
  }
}