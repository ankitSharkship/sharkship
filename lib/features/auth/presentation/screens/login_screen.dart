import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/auth/data/models/register_user_request_model.dart';
import 'package:sharkship/features/auth/presentation/state/signup_notifier.dart';
import 'package:sharkship/features/auth/presentation/state/signup_state.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/error_popup.dart';
import '../../../../shared/widgets/custom_error_widget.dart';
import '../../../../shared/widgets/loader.dart';
import '../../../../utlis/validators.dart';
import '../state/auth_notifier.dart';

class AuthScreen extends ConsumerStatefulWidget {
  final String initialMode;
  const AuthScreen({super.key, required this.initialMode});

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
  final emailController = TextEditingController();
  final createPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final businessNameController = TextEditingController();
  final landmarkController = TextEditingController();
  final businessOwnershipTypeController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final pinController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  final otpControllers = List.generate(4, (_) => TextEditingController());
  final otpFocusNodes = List.generate(4, (_) => FocusNode());

  Timer? _resendTimer;
  int _secondsRemaining = 20;
  @override
  void initState() {
    isLogin = widget.initialMode == "login";
    super.initState();
  }

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

    ref
        .read(authProvider.notifier)
        .otpLogin(
          phoneController.text.trim(),
          currentVerifyId ?? "",
          otp,
          () => context.go('/splash'),
        );
  }

  void _handleFinalStep() {
    final signupState = ref.read(signupProvider);
    final signup = ref.watch(signupProvider.notifier);
    final phone = signupState.form['phoneNumber'] ?? '';

    ref.read(authProvider.notifier).authenticate(phone, (verifyId) {
      print("OTP SENT");
      signup.updateField("verifyId", verifyId);
      signup.nextStep();
    });
  }

  void _nextStep() {
    final isValid = _signupFormKey.currentState!.validate();
    print(isValid);
    if (!isValid) return;

    ref.read(signupProvider.notifier).nextStep();
  }

  void _previousStep() {
    ref.read(signupProvider.notifier).prevStep();
  }

  void _signup() {
    print("hello");
    final signup = ref.read(signupProvider);
    final otp = otpControllers.map((e) => e.text).join();
    if (otp.length != 4) {
      CustomErrorWidget.show(context, errorMessage: "Please enter 4-digit OTP");
      return;
    }
    print(otp);

    const entityTypeMap = {
      'Sole Proprietorship': 'SOLE_PROPRIETORSHIP',
      'Private Limited Company': 'PRIVATE_LIMITED_COMPANY',
      'Limited Liability Partnership(LLP)': 'LIMITED_LIABILITY_PARTNERSHIP',
    };
    final entityType =
        entityTypeMap[signup.form['ownershipType']] ?? 'SOLE_PROPRIETORSHIP';

    final request = RegisterUserRequestModel(
      otp: otp,
      verifyId: signup.form["verifyId"]!,
      firstName: signup.form['firstName']!,
      lastName: signup.form['lastName']!,
      phoneNo: int.parse(signup.form['phoneNumber']!),
      password: signup.form['createPassword']!,
      email: signup.form['email']!,
      businessName: signup.form['businessName']!,
      typeOfBusiness: signup.form['category']!,
      entityType: entityType,
      businessAddress: BusinessAddressModel(
        addressLane1: signup.form['address1']!,
        landmark: signup.form["landmark"] ?? "",
        pin: int.parse(signup.form['pin']!),
        city: signup.form['city']!,
        state: signup.form['state']!,
        name: signup.form['businessName']!,
        phoneNo: signup.form['phoneNumber']!,
      ),
    );
    print(signup.form["verifyId"]);
    print(request);
    ref
        .read(authProvider.notifier)
        .registerUser(
          request: request,
          onSuccess: () {
            context.go(Routes.KYC);
          },
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
    void showErrorPopup(BuildContext context, String message) {
      showDialog(
        context: context,
        barrierDismissible: true, // allow tap outside
        builder: (_) => ErrorPopup(message: message),
      );
    }

    ref.listen<AsyncValue<void>>(authProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        // CustomErrorWidget.show(context, errorMessage: next.error.toString());
        showErrorPopup(context, next.error.toString());
      }
    });
    // Inside your build method in AuthScreen
    ref.listen(signupProvider.select((s) => s.form['city']), (prev, next) {
      if (next != null && next != cityController.text) {
        cityController.text = next;
      }
    });

    ref.listen(signupProvider.select((s) => s.form['state']), (prev, next) {
      if (next != null && next != stateController.text) {
        stateController.text = next;
      }
    });
    final authState = ref.watch(authProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.loginGradientStart,
                  AppColors.loginGradientEnd,
                ],
              ),
            ),
            child: Column(
              children: [
                Expanded(flex: 3, child: _buildTopSection()),
                Expanded(flex: 8, child: _buildBottomSheet()),
              ],
            ),
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
          colors: [AppColors.loginGradientStart, AppColors.loginGradientEnd],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/login/login_logo.png",
                    height: 28,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Get Started Now",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                "Create an account or log in to explore about our app",

                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Color.fromARGB(179, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= BOTTOM =================
  Widget _buildBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBg,
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
              isLogin ? _buildLoginForm() : _buildSignupForm(),

            const SizedBox(height: 20),
            if (isLogin) ...[
              _buildDivider(),
              const SizedBox(height: 20),

              // _socialButton("Continue With Google"),
              // const SizedBox(height: 12),
              _socialButton(
                isPasswordLogin ? "Login With OTP" : "Login With Password",
                onTap: () {
                  setState(() {
                    isPasswordLogin = !isPasswordLogin;
                  });
                },
              ),
            ],
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
      child: Row(children: [_tab("Log In", true), _tab("Sign Up", false)]),
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
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: selected ? AppColors.loginGradientStart : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  /// ================= FORMS =================
  Widget _buildOtpForm() {
    final signupState = ref.watch(signupProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Verify OTP", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        Text(
          "Enter the 4 digit OTP sent to Phone Number / Email",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              "+91 ${phoneController.text}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.loginGradientStart,
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
        const SizedBox(height: 12),

        if (isLogin) _buildPrimaryButtonLogin(),
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
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontSize: 24),
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
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: _secondsRemaining == 0
                  ? AppColors.loginGradientStart
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        Form(
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
                  validator: (v) => v != null && v.isNotEmpty
                      ? null
                      : 'Please enter password',
                  obscureText: true,
                ),
              ],
              const SizedBox(height: 20),
              _buildPrimaryButtonLogin(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignupForm() {
    final signupState = ref.watch(signupProvider);

    return Column(
      children: [
        Form(
          key: _signupFormKey,
          child: Builder(
            builder: (_) {
              switch (signupState.step) {
                case 0:
                  return _buildSignupStep1();
                case 1:
                  return _buildSignupStep2();
                case 2:
                  return _buildSignupStep3();
                case 3:
                  return _buildSignupStep4();
                default:
                  return _buildOtpForm();
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        _buildSignupActions(signupState),
      ],
    );
  }

  Widget _buildSignupStep1() {
    final signupNotifier = ref.read(signupProvider.notifier);
    final signup = ref.watch(signupProvider);
    return Column(
      children: [
        _input(
          label: "First Name *",
          hint: "Enter First Name",
          controller: firstNameController,
          validator: Validators.name,
          onChanged: (val) => signupNotifier.updateField('firstName', val),
        ),
        _input(
          label: "Last Name *",
          hint: "Enter Last Name",
          controller: lastNameController,
          validator: Validators.name,
          onChanged: (value) => signupNotifier.updateField("lastName", value),
        ),
        _input(
          label: "Phone Number *",
          hint: "Enter Your Phone Number",
          controller: phoneController,
          validator: Validators.phone,
          onChanged: (value) =>
              signupNotifier.updateField("phoneNumber", value),
        ),
      ],
    );
  }

  Widget _buildSignupStep2() {
    final signupNotifier = ref.read(signupProvider.notifier);
    return Column(
      children: [
        _input(
          label: "Email *",
          hint: "Enter Your Email",
          controller: emailController,
          validator: Validators.email,
          onChanged: (val) => signupNotifier.updateField('email', val),
        ),
        _input(
          label: "Create Password *",
          hint: "Enter Your Password",
          controller: createPasswordController,
          validator: Validators.password,
          onChanged: (value) =>
              signupNotifier.updateField("createPassword", value),
        ),
        _input(
          label: "Confirm Password *",
          hint: "Re-Enter Your Password",
          controller: confirmPasswordController,
          validator: Validators.password,
          onChanged: (value) =>
              signupNotifier.updateField("confirmPassword", value),
        ),
      ],
    );
  }

  final List<String> categories = [
    "Clothing",
    "Mobile phone & accesories",
    "Beauty & Personal care",
    "Home Decor",
    "Home & Kitchen Appliances",
    "Footwear",
    "Jewellery & Watches",
    "Documents",
    "Food and Beverage",
    "Miscellaneous",
  ];
  final List<String> ownerShip = [
    "Sole Proprietorship",
    "Private Limited Company",
    "Limited Liability Partnership(LLP)",
  ];
  Widget _buildSignupStep3() {
    final signupNotifier = ref.read(signupProvider.notifier);
    final signupState = ref.watch(signupProvider);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _input(
                label: "Business Name *",
                hint: "Enter Business Name",
                controller: businessNameController,
                validator: Validators.name,
                onChanged: (val) =>
                    signupNotifier.updateField('businessName', val),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _dropdown(
                label: "Business Category *",
                hint: "Select Category",
                value: signupState.form['category'],
                items: categories,
                validator: (v) => v == null ? "Please select a category" : null,
                onChanged: (val) {
                  if (val != null) {
                    signupNotifier.updateField('category', val);
                  }
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _dropdown(
                label: "Ownership Type *",
                hint: "Select Category",
                value: signupState.form['ownershipType'],
                items: ownerShip,
                validator: (v) =>
                    v == null ? "Please select an Ownership Type" : null,
                onChanged: (val) {
                  if (val != null) {
                    signupNotifier.updateField('ownershipType', val);
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _input(
                label: "Address Line 1*",
                hint: "Enter Address Line 1",
                controller: addressLine1Controller,
                validator: Validators.address,
                onChanged: (value) =>
                    signupNotifier.updateField("address1", value),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _input(
                label: "Address Line 2",
                hint: "Enter Address Line 2",
                controller: addressLine2Controller,
                onChanged: (value) =>
                    signupNotifier.updateField("address2", value),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _input(
                label: "PIN *",
                hint: "Enter PIN",
                controller: pinController,
                keyboard: TextInputType.number,
                validator: Validators.pincode,
                onChanged: (value) {
                  signupNotifier.updateField("pin", value);
                  // Trigger fetch only when a valid 6-digit pin is entered
                  if (value.length == 6) {
                    print('hellloooo');
                    signupNotifier.fetchCityState(value);
                  }
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _input(
                label: "Landmark",
                hint: "Enter Landmark",
                controller: landmarkController,
                onChanged: (value) =>
                    signupNotifier.updateField("landmark", value),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _input(
                label: "City *",
                hint: "Enter City Name",
                controller: cityController,
                validator: Validators.city,
                onChanged: (value) => signupNotifier.updateField("city", value),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _input(
                label: "State *",
                hint: "Enter State",
                controller: stateController,
                validator: Validators.state,
                onChanged: (value) =>
                    signupNotifier.updateField("state", value),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignupStep4() {
    final signupState = ref.watch(signupProvider);
    final notifier = ref.read(signupProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirm Details:",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
        ),
        const SizedBox(height: 20),

        // Personal Details Section
        _buildDetailSection(
          title: "Personal Details",
          onEdit: () => notifier.goToStep(0), // Navigates back to step 0
          details: {
            "First Name": signupState.form['firstName'] ?? "",
            "Last Name": signupState.form['lastName'] ?? "",
            "Email": signupState.form['email'] ?? "",
            "Phone Number": signupState.form['phoneNumber'] ?? "",
          },
        ),

        const SizedBox(height: 20),

        // Company Details Section
        _buildDetailSection(
          title: "Company Details",
          onEdit: () => notifier.goToStep(2), // Navigates back to step 2
          details: {
            "Business Name": signupState.form['businessName'] ?? "",
            "Category": signupState.form['category'] ?? "",
            "Address Line 1": signupState.form['address1'] ?? "",
            "Address Line 2": signupState.form['address2'] ?? "",
            "Landmark": signupState.form['landmark'] ?? "",
            "City": signupState.form['city'] ?? "",
            "State": signupState.form['state'] ?? "",
            "Pin": signupState.form['pin'] ?? "",
          },
        ),

        const SizedBox(height: 30),

        // Terms and Conditions Checkbox
        _buildTermsCheckbox(signupState, notifier),
      ],
    );
  }

  Widget _buildDetailSection({
    required String title,
    required VoidCallback onEdit,
    required Map<String, String> details,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 18),
            ),
            GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.loginGradientStart,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
        const Divider(thickness: 1, color: Colors.grey),
        ...details.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              "${entry.key}: ${entry.value}",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(SignupState state, SignupNotifier notifier) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: state.acceptedTerms,
            onChanged: (val) => notifier.toggleTerms(val ?? false),
            activeColor: AppColors.loginGradientStart,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black),
              children: [
                const TextSpan(text: "I agree to the "),
                TextSpan(
                  text: "Terms of Service",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.loginGradientStart,
                  ),
                  // Add recognizer: TapGestureRecognizer()..onTap = () => ...
                ),
                const TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.loginGradientStart,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// ================= INPUT =================
  Widget _input({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    TextInputType keyboard = TextInputType.text,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          // If validator is null, it just returns null (valid) by default
          validator: validator,
          keyboardType: keyboard,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 18),
                    onPressed: () {
                      controller.clear();
                      if (onChanged != null) onChanged('');
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(
            hint,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
            overflow: TextOverflow.ellipsis, // Added for hint overflow
          ),
          isExpanded: true,
          validator: validator,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(14),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Wrap the text in Expanded to take up available space
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge,
                      // 2. Set overflow to ellipsis (...)
                      overflow: TextOverflow.ellipsis,
                      // 3. Prevent text from wrapping to a second line
                      maxLines: 1,
                    ),
                  ),
                  if (value == item) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.check,
                      color: AppColors.loginGradientStart,
                      size: 20,
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// ================= BUTTON =================
  Widget _buildPrimaryButtonLogin() {
    final signupState = ref.watch(signupProvider);

    // final text = isOtpMode
    //     ? "Verify & Log In"
    //     : (isLogin ? "Continue" : (signupState.step != 3 ? "Next" : "Submit"));
    final text = isOtpMode ? "Verify & Log In" : "Continue";

    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.loginGradientEnd, AppColors.loginGradientStart],
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
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: isLogin ? (isOtpMode ? _verifyOtp : _submit) : _nextStep,
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildSignupActions(SignupState signupState) {
    // Check if we are at the start or very end
    if (signupState.step == 0) {
      return Row(
        children: [
          Expanded(flex: 1, child: _buildPrimaryButtonSignupNext(true)),
        ],
      );
    }

    // Otherwise, show both buttons side-by-side
    return Row(
      children: [
        // Wrapping in Expanded tells the button: "Take half the row"
        Expanded(child: _buildPrimaryButtonSignupNext(false)),
        const SizedBox(width: 12), // Space between buttons
        Expanded(child: _buildPrimaryButtonSignupNext(true)),
      ],
    );
  }

  Widget _buildPrimaryButtonSignupNext(bool isNextOrSubmit) {
    final signupState = ref.watch(signupProvider);

    // Logic for button text
    final String text;
    if (isNextOrSubmit) {
      if (signupState.step == 3) {
        text = "Submit";
      } else if (signupState.step == 4) {
        text = "Verify & Signup";
      } else {
        text = "Next";
      }
    } else {
      text = "Previous";
    }

    VoidCallback? getOnPressed() {
      if (!isNextOrSubmit) return _previousStep;

      return switch (signupState.step) {
        3 => _handleFinalStep,
        4 => _signup,
        _ => _nextStep,
      };
    }

    return Container(
      height: 52,
      // Note: Removed width: double.infinity so it respects the Parent (Expanded)
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Tip: Maybe use a grey gradient for "Previous" to distinguish it?
          colors: isNextOrSubmit
              ? [AppColors.loginGradientEnd, AppColors.loginGradientStart]
              : [Colors.grey.shade400, Colors.grey.shade600],
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
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: getOnPressed(),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("Or", style: Theme.of(context).textTheme.bodyMedium),
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
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
