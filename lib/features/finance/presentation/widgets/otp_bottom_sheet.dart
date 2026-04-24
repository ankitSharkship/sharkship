import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpBottomSheet extends ConsumerStatefulWidget {
  final String title;
  final Future<bool> Function(String otp) onVerify;

  const OtpBottomSheet({
    super.key,
    required this.title,
    required this.onVerify,
  });

  @override
  ConsumerState<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends ConsumerState<OtpBottomSheet> {
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;
  String? _error;

  Future<void> _handleVerify() async {
    final otp = _otpController.text.trim();

    if (otp.length != 4) {
      setState(() => _error = 'Enter valid OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final success = await widget.onVerify(otp);

      if (!mounted) return;

      if (!success) {
        setState(() {
          _isLoading = false;
          _error = 'Verification failed';
        });
        return;
      }

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, bottomInset + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter 4 digit OTP',
              counterText: '',
              errorText: _error,
            ),
          ),

          const SizedBox(height: 16),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: CircularProgressIndicator(),
            ),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isLoading
                      ? null
                      : () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleVerify,
                  child: const Text('Verify'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}