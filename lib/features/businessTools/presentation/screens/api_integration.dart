import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/businessTools/presentation/state/retail_api_notifier.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/in_app_webview.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class ApiIntegration extends ConsumerStatefulWidget {
  const ApiIntegration({super.key});

  @override
  ConsumerState<ApiIntegration> createState() => _ApiIntegrationState();
}

class _ApiIntegrationState extends ConsumerState<ApiIntegration> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(retailApiProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: const Text('API Integration'),
        backgroundColor: AppColors.scaffoldBg,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            state.when(
              data: (data) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 30,
                    ),
                    child: ApiCredentialCard(
                      apiKey: data.apiKey,
                      apiSecret: data.apiSecret,
                      isActive: data.status,
                    ),
                  ),
                );
              },
              error: (err, st) => ErrorWidget(err),
              loading: () => ThreeDotsLoader(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GradientButton(
                text: '📎 Visit Our Api Docs',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InAppBrowserScreen(
                        url:
                            "https://documenter.getpostman.com/view/50875083/2sB3dVMn11",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiCredentialCard extends StatefulWidget {
  final String apiKey;
  final String apiSecret;
  final String isActive;

  const ApiCredentialCard({
    super.key,
    required this.apiKey,
    required this.apiSecret,
    required this.isActive,
  });

  @override
  State<ApiCredentialCard> createState() => _ApiCredentialCardState();
}

class _ApiCredentialCardState extends State<ApiCredentialCard> {
  bool _showSecret = false;
  bool _showKey = false;

  void _copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

  String _masked(String text) {
    if (text.length <= 6) return '******';
    return '${text.substring(0, 4)}******${text.substring(text.length - 2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row (Icon + Status)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 80),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.red),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.store, size: 68, color: Colors.red),
              ),

              /// Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF3EA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.isActive,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF1B7F5F),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// API SECRET
          _rowItem(
            label: 'API SECRET',
            value: widget.apiSecret,
            visible: _showSecret,
            onToggle: () => setState(() => _showSecret = !_showSecret),
          ),

          const SizedBox(height: 12),

          /// API KEY
          _rowItem(
            label: 'API KEY',
            value: widget.apiKey,
            visible: _showKey,
            onToggle: () => setState(() => _showKey = !_showKey),
          ),
        ],
      ),
    );
  }

  Widget _rowItem({
    required String label,
    required String value,
    required bool visible,
    required VoidCallback onToggle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Text
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                ),
                TextSpan(
                  text: visible ? value : _masked(value),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),

        /// Actions
        Row(
          children: [
            IconButton(
              icon: Icon(
                visible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: onToggle,
            ),
            IconButton(
              icon: const Icon(Icons.copy, color: Colors.grey),
              onPressed: () => _copy(value),
            ),
          ],
        ),
      ],
    );
  }
}
