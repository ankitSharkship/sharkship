class SignupState {
  final int step;
  final Map<String, String> form;
  final bool acceptedTerms;
  final bool isOtpMode;
  final bool loading;

  const SignupState({
    this.step = 0,
    this.form = const {},
    this.acceptedTerms = false,
    this.isOtpMode = false,
    this.loading = false,
  });

  SignupState copyWith({
    int? step,
    Map<String, String>? form,
    bool? acceptedTerms,
    bool? isOtpMode,
    bool? loading,
  }) {
    return SignupState(
      step: step ?? this.step,
      form: form ?? this.form,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      isOtpMode: isOtpMode ?? this.isOtpMode,
      loading: loading ?? this.loading,
    );
  }
}