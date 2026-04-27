import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/auth/presentation/state/signup_state.dart';
import 'package:sharkship/features/businessTools/presentation/state/manage_address_notifier.dart';
part 'signup_notifier.g.dart';

@riverpod
class SignupNotifier extends _$SignupNotifier {
  @override
  SignupState build() {
    return const SignupState();
  }

  void updateField(String key, String value) {
    final updated = Map<String, String>.from(state.form);
    updated[key] = value;
    state = state.copyWith(form: updated);
  }

  void nextStep() {
    if (!validate()) {
      return;
    }
    if (state.step < 4) {
      state = state.copyWith(step: state.step + 1);
    } else {
      return;
      // sendOTP();
    }
  }

  void prevStep() {
    if (state.step > 0) {
      state = state.copyWith(step: state.step - 1);
    }
  }

  void goToStep(int step) {
    state = state.copyWith(step: step);
  }

  void toggleTerms(bool value) {
    state = state.copyWith(acceptedTerms: value);
  }

  Future<void> fetchCityState(String pin) async {
    if (state.loading) return;
    state = state.copyWith(loading: true);
    try {
      final result = await ref
          .read(manageAddressProvider.notifier)
          .getPinDetails(pin);
      if (result != null && result?.city != null && result?.state != null) {
        final updated = Map<String, String>.from(state.form);
        updated['city'] = "";
        updated['state'] = "Delhi";

        state = state.copyWith(loading: false, form: updated);
      } else {
        state = state.copyWith(loading: false);
      }
    } catch (e) {
      state = state.copyWith(loading: false);
    }
  }

  bool validate() {
    switch (state.step) {
      case 0:
        return (state.form['phoneNumber'] ?? '').isNotEmpty;
      case 1:
        return state.form['createPassword'] == state.form['confirmPassword'];
      case 2:
        return (state.form['pin'] ?? '').length == 6;
      case 3:
        return state.acceptedTerms;
      default:
        return true;
    }
  }

  Future<void> sendOTP() async {
    state = state.copyWith(loading: true);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(loading: false, isOtpMode: true);
  }
}
