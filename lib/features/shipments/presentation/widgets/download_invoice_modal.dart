import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/widgets/orders_header.dart';
import 'package:sharkship/shared/constants/colors.dart';

class DownloadInvoiceModal extends ConsumerStatefulWidget {
  final List<int> orderIds;

  const DownloadInvoiceModal({super.key, required this.orderIds});

  @override
  ConsumerState<DownloadInvoiceModal> createState() =>
      _DownloadInvoiceModalState();
}

class _DownloadInvoiceModalState extends ConsumerState<DownloadInvoiceModal> {
  String _selectedFormat = 'A4';
  bool _isLoading = false;

  Future<void> _handleDownload() async {
    setState(() => _isLoading = true);

    final messenger = ScaffoldMessenger.of(context);

    // We stick to the default flags mentioned in the curl:
    // show_logo: true, show_company_details: true, show_gstin: true
    final config = {
      "format": _selectedFormat == 'A4' ? 'A4' : 'THERMAL',
      "show_logo": true,
      "show_company_details": true,
      "show_gstin": true,
    };

    try {
      await ref
          .read(downloadOrderInvoiceUseCaseProvider)
          .execute(config, widget.orderIds);

      if (mounted) {
        Navigator.pop(context);
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: const StatusNotification(
              message: 'Invoice downloaded successfully',
              status: StatusType.success,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: 'Error: ${e.toString().replaceAll('Exception: ', '')}',
              status: StatusType.error,
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.scaffoldBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Download Order Invoice',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Download the order invoice for the selected orders.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _FormatOptionCard(
                    title: 'A4 Format',
                    subtitle: 'Standard paper size',
                    icon: Icons.description_outlined,
                    isSelected: _selectedFormat == 'A4',
                    onTap: () => setState(() => _selectedFormat = 'A4'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _FormatOptionCard(
                    title: 'Thermal Print',
                    subtitle: 'Receipt printer format',
                    icon: Icons.print_outlined,
                    isSelected: _selectedFormat == 'THERMAL',
                    onTap: () => setState(() => _selectedFormat = 'THERMAL'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleDownload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Download Invoice'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FormatOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FormatOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? ColorManager.primaryBlue : Colors.grey.shade200,
            width: 2,
          ),
          color: isSelected
              ? ColorManager.primaryBlue.withOpacity(0.05)
              : Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorManager.primaryBlue.withOpacity(0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? ColorManager.primaryBlue : Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? ColorManager.primaryBlue : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? ColorManager.primaryBlue.withOpacity(0.7)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
