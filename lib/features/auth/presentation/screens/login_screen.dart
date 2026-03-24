import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/custom_error_widget.dart';
import '../../../../shared/widgets/loader.dart';
import '../../../../utlis/validators.dart';
import '../state/auth_notifier.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool isLogin = true;
  bool isPasswordLogin = false;
  bool isOtpMode = false;
  String? currentVerifyId;

  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final otpControllers = List.generate(4, (_) => TextEditingController());
  final otpFocusNodes = List.generate(4, (_) => FocusNode());

  Timer? _resendTimer;
  int _secondsRemaining = 20;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in otpFocusNodes) {
      f.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _secondsRemaining = 20);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _resendTimer?.cancel();
      }
    });
  }

  void _verifyOtp() {
    final otp = otpControllers.map((e) => e.text).join();
    if (otp.length != 4) {
      CustomErrorWidget.show(context, errorMessage: "Please enter 4-digit OTP");
      return;
    }

    ref.read(authProvider.notifier).otpLogin(
      phoneController.text.trim(),
      currentVerifyId ?? "",
      otp,
      () => context.go('/home'),
    );
  }

  void _submit() {
    final isValid = isLogin
        ? _loginFormKey.currentState!.validate()
        : _signupFormKey.currentState!.validate();

    if (!isValid) return;

    if (isLogin) {
      if (isPasswordLogin) {
        ref.read(authProvider.notifier).passwordLogin(
          phoneController.text.trim(),
          passwordController.text,
          () {
            context.go('/home'); // Replaced /dashboard
          },
        );
      } else {
        ref.read(authProvider.notifier).generateOtp(
          phoneController.text.trim(),
          (verifyId) {
            setState(() {
              isOtpMode = true;
              currentVerifyId = verifyId;
            });
            _startResendTimer();
          },
        );
      }
    } else {
      // Signup logic can be placed here later
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        CustomErrorWidget.show(
          context,
          errorMessage: next.error.toString(),
        );
      }
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 3, child: _buildTopSection()),
              Expanded(flex: 8, child: _buildBottomSheet()),
            ],
          ),
          if (authState.isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: ThreeDotsLoader()),
            ),
        ],
      ),
    );
  }

  /// ================= TOP =================
  Widget _buildTopSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E88C8), Color(0xFF6EC1E4)],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/login/login_logo.png",
                    height: 28),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Get Started Now",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Create an account or log in to explore about our app",
              style: TextStyle(
                color: Color.fromARGB(179, 255, 255, 255),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= BOTTOM =================
  Widget _buildBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildToggle(),
            const SizedBox(height: 20),
            if (isOtpMode)
              _buildOtpForm()
            else
              isLogin
                  ? _buildLoginForm()
                  : _buildSignupForm(),
            const SizedBox(height: 20),
            _buildPrimaryButton(),
            const SizedBox(height: 20),
            _buildDivider(),
            const SizedBox(height: 20),
            _socialButton("Continue With Google"),
            const SizedBox(height: 12),
            if (isLogin)
              _socialButton(
                isPasswordLogin ? "Login With OTP" : "Login With Password",
                onTap: () {
                  setState(() {
                    isPasswordLogin = !isPasswordLogin;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  /// ================= TOGGLE =================
  Widget _buildToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _tab("Log In", true),
          _tab("Sign Up", false),
        ],
      ),
    );
  }

  Widget _tab(String text, bool value) {
    final selected = isLogin == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isLogin = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? const Color(0xFF1E88C8) : Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// ================= FORMS =================
  Widget _buildOtpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Verify OTP",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "Enter the 4 digit OTP sent to Phone Number / Email",
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              "+91 ${phoneController.text}",
              style: const TextStyle(
                color: Color(0xFF1E88C8),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => setState(() => isOtpMode = false),
              child: const Icon(Icons.edit, size: 16, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildOtpBoxes(),
        const SizedBox(height: 12),
        _buildResendSection(),
      ],
    );
  }

  Widget _buildOtpBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 60,
          child: TextField(
            controller: otpControllers[index],
            focusNode: otpFocusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                otpFocusNodes[index + 1].requestFocus();
              }
              if (value.isEmpty && index > 0) {
                otpFocusNodes[index - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildResendSection() {
    return Row(
      children: [
        const Text("Didn't receive OTP? "),
        GestureDetector(
          onTap: _secondsRemaining == 0 ? _submit : null,
          child: Text(
            _secondsRemaining == 0
                ? "Resend"
                : "Resent in 0:${_secondsRemaining.toString().padLeft(2, '0')}",
            style: TextStyle(
              color: _secondsRemaining == 0
                  ? const Color(0xFF1E88C8)
                  : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          _input(
            label: "Phone Number *",
            hint: "Enter Phone Number",
            controller: phoneController,
            validator: Validators.phone,
            keyboard: TextInputType.phone,
          ),
          if (isPasswordLogin) ...[
            const SizedBox(height: 14),
            _input(
              label: "Password *",
              hint: "Enter Password",
              controller: passwordController,
              validator: (v) =>
                  v != null && v.isNotEmpty ? null : 'Please enter password',
              obscureText: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSignupForm() {
    return Form(
      key: _signupFormKey,
      child: Column(
        children: [
          _input(
            label: "First Name *",
            hint: "Enter Your First Name",
            controller: firstNameController,
            validator: Validators.name,
          ),
          const SizedBox(height: 14),
          _input(
            label: "Last Name *",
            hint: "Enter Your Last Name",
            controller: lastNameController,
            validator: Validators.name,
          ),
          const SizedBox(height: 14),
          _input(
            label: "Phone Number *",
            hint: "Enter Your 10 Digit Mobile Number",
            controller: phoneController,
            validator: Validators.phone,
            keyboard: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  /// ================= INPUT =================
  Widget _input({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboard = TextInputType.text,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboard,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  /// ================= BUTTON =================
  Widget _buildPrimaryButton() {
    final text = isOtpMode
        ? "Verify & Log In"
        : (isLogin ? "Continue" : "Next");

    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6EC1E4), Color(0xFF1E88C8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: isOtpMode ? _verifyOtp : _submit,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("Or"),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  /// ================= SOCIAL =================
  Widget _socialButton(String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
