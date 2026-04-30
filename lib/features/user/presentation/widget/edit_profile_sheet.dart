import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/user/presentation/state/edit_profile_notifier.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';

Future<void> showEditProfileSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.85,
    ),
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _EditProfileSheet(),
  );
}

class _EditProfileSheet extends ConsumerStatefulWidget {
  const _EditProfileSheet();

  @override
  ConsumerState<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<_EditProfileSheet> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _businessNameController;
  late TextEditingController _otpController;
  String? _businessType;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider).value;
    _firstNameController = TextEditingController(text: user?.firstName);
    _lastNameController = TextEditingController(text: user?.lastName);
    _emailController = TextEditingController(text: user?.email);
    _phoneController = TextEditingController(text: user?.phoneNo);
    _businessNameController = TextEditingController(text: user?.businessName);
    _otpController = TextEditingController();
    _businessType = user?.typeOfBusiness;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _businessNameController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<EditProfileState>(editProfileProvider, (_, next) {
      if (next.step == EditProfileStep.success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully! 🎉'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(editProfileProvider.notifier).reset();
      }
    });

    final state = ref.watch(editProfileProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          ref.read(editProfileProvider.notifier).reset();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: ColorManager.lightBlueBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: state.step == EditProfileStep.otpVerification
              ? _OtpStep(
                  key: const ValueKey('otp'),
                  state: state,
                  otpController: _otpController,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  phoneNo: _phoneController.text,
                  businessName: _businessNameController.text,
                  typeOfBusiness: _businessType ?? '',
                )
              : _FormStep(
                  key: const ValueKey('form'),
                  state: state,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  businessNameController: _businessNameController,
                  businessType: _businessType,
                  onBusinessTypeChanged: (val) =>
                      setState(() => _businessType = val),
                ),
        ),
      ),
    );
  }
}

class _FormStep extends ConsumerWidget {
  final EditProfileState state;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController businessNameController;
  final String? businessType;
  final ValueChanged<String?> onBusinessTypeChanged;

  const _FormStep({
    super.key,
    required this.state,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.businessNameController,
    required this.businessType,
    required this.onBusinessTypeChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(editProfileProvider.notifier);
    final user = ref.read(userProvider).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Row(
          children: [
            const Text(
              'Edit Profile Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Keep your details up-to-date for a seamless experience.',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
        const SizedBox(height: 24),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FieldLabel('First Name'),
                const SizedBox(height: 6),
                _InputField(
                  controller: firstNameController,
                  hint: 'First Name',
                  onChanged: (_) => notifier.clearError(),
                ),
                const SizedBox(height: 16),
                _FieldLabel('Last Name'),
                const SizedBox(height: 6),
                _InputField(
                  controller: lastNameController,
                  hint: 'Last Name',
                  onChanged: (_) => notifier.clearError(),
                ),
                const SizedBox(height: 16),
                _FieldLabel('Email'),
                const SizedBox(height: 6),
                _InputField(
                  controller: emailController,
                  hint: 'Email',
                  onChanged: (_) => notifier.clearError(),
                ),
                const SizedBox(height: 16),
                _FieldLabel('Mobile Number'),
                const SizedBox(height: 6),
                _InputField(
                  controller: phoneController,
                  hint: 'Mobile Number',
                  keyboardType: TextInputType.phone,
                  onChanged: (_) => notifier.clearError(),
                ),
                const SizedBox(height: 16),
                _FieldLabel('Business Name'),
                const SizedBox(height: 6),
                _InputField(
                  controller: businessNameController,
                  hint: 'Business Name',
                  onChanged: (_) => notifier.clearError(),
                ),
                const SizedBox(height: 16),
                _FieldLabel('Business Type'),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: businessType,
                      hint: const Text('Select Business Type'),
                      items:
                          [
                                'Clothing',
                                'Mobile phone & accesories',
                                'Beauty & Personal care',
                                'Home Decor',
                                'Home & Kitchen Appliances',
                                'Footwear',
                                'Jewellery & Watches',
                                'Documents',
                                'Food and Beverage',
                                'Miscellaneous',
                              ]
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: onBusinessTypeChanged,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _FieldLabel('Account Status'),
                const SizedBox(height: 6),
                _InputField(
                  controller: TextEditingController(
                    text: user?.status ?? 'ACTIVE',
                  ),
                  hint: 'Account Status',
                  enabled: false,
                ),
                if (state.error != null) ...[
                  const SizedBox(height: 12),
                  _ErrorBanner(message: state.error!),
                ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        GradientButton(
          text: 'Submit',
          onTap: state.isLoading
              ? null
              : () {
                  FocusScope.of(context).unfocus();
                  notifier.submitForm(
                    phoneNo: phoneController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    businessName: businessNameController.text,
                    typeOfBusiness: businessType ?? '',
                  );
                },
          child: state.isLoading ? const ThreeDotsLoader() : null,
        ),
      ],
    );
  }
}

class _OtpStep extends ConsumerWidget {
  final EditProfileState state;
  final TextEditingController otpController;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  final String businessName;
  final String typeOfBusiness;

  const _OtpStep({
    super.key,
    required this.state,
    required this.otpController,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.businessName,
    required this.typeOfBusiness,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(editProfileProvider.notifier);
    final user = ref.read(userProvider).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const Row(
          children: [
            Text(
              'Enter OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'A 4-digit OTP has been sent to +91 $phoneNo.',
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 12,
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: '- - - -',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 28,
              letterSpacing: 12,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
          onChanged: (_) => notifier.clearError(),
        ),
        if (state.error != null) ...[
          const SizedBox(height: 12),
          _ErrorBanner(message: state.error!),
        ],
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Didn't receive OTP? ",
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            GestureDetector(
              onTap: state.resendCooldownSeconds > 0 || state.isLoading
                  ? null
                  : () => notifier.resendOtp(phoneNo),
              child: Text(
                state.resendCooldownSeconds > 0
                    ? 'Resend in ${state.resendCooldownSeconds}s'
                    : 'Resend OTP',
                style: TextStyle(
                  color: state.resendCooldownSeconds > 0
                      ? Colors.grey
                      : Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextButton(
              onPressed: state.isLoading
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      notifier.verifyOtpAndUpdate(
                        otp: otpController.text,
                        userId: user?.id ?? '',
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        phoneNo: phoneNo,
                        businessName: businessName,
                        typeOfBusiness: typeOfBusiness,
                        context: context,
                      );
                    },
              child: state.isLoading
                  ? const ThreeDotsLoader()
                  : const Text(
                      'Verify & Update Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const Text(' *', style: TextStyle(color: Colors.orange)),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool enabled;
  final void Function(String)? onChanged;

  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      onChanged: onChanged,
      style: TextStyle(
        color: enabled ? Colors.black : Colors.grey,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.red.shade700, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
