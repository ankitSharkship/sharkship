import 'package:sharkship/features/kyc/domain/entities/kyc.dart';

enum KycStep { aadhaar, pan, bank, gst, review, submitted }
class KycState {
  final Kyc kyc;
  final KycStep currentStep;
  final bool isLoading;
  final String? error;

  KycState({
    required this.kyc,
    required this.currentStep,
    this.isLoading = false,
    this.error,
  });

  KycState copyWith({
    Kyc? kyc,
    KycStep? currentStep,
    bool? isLoading,
    String? error,
  }) {
    return KycState(
      kyc: kyc ?? this.kyc,
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}