import 'package:sharkship/features/kyc/domain/entities/kyc.dart';

enum KycStep { aadhaar, pan, bank, gst, review, terms, submitted }

class KycState {
  final Kyc kyc;
  final KycStep currentStep;
  final bool isTermsAccepted;
  final String? termsHtml;
  final bool shouldNavigateHome;

  KycState({
    required this.kyc,
    required this.currentStep,
    this.isTermsAccepted = false,
    this.termsHtml,
    this.shouldNavigateHome = false,
  });

  KycState copyWith({
    Kyc? kyc,
    KycStep? currentStep,
    bool? isTermsAccepted,
    String? termsHtml,
    bool? shouldNavigateHome,
  }) {
    return KycState(
      kyc: kyc ?? this.kyc,
      currentStep: currentStep ?? this.currentStep,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      termsHtml: termsHtml ?? this.termsHtml,
      shouldNavigateHome: shouldNavigateHome ?? this.shouldNavigateHome,
    );
  }
}
