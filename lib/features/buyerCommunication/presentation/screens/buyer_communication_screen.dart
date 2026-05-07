import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sharkship/features/buyerCommunication/domain/entities/whatsapp_config_entity.dart';
import 'package:sharkship/features/buyerCommunication/presentation/state/buyer_communication_notifier.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class BuyerCommunicationScreen extends ConsumerStatefulWidget {
  const BuyerCommunicationScreen({super.key});

  @override
  ConsumerState<BuyerCommunicationScreen> createState() =>
      _BuyerCommunicationScreenState();
}

class _BuyerCommunicationScreenState
    extends ConsumerState<BuyerCommunicationScreen> {
  late TextEditingController _whatsappController;
  bool _isDemoLoading = false;

  @override
  void initState() {
    super.initState();
    _whatsappController = TextEditingController();
  }

  @override
  void dispose() {
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _updateConfig(String key, bool value) async {
    final state = ref
        .read(buyerCommunicationProvider)
        .asData
        ?.value
        .whatsappConfig;
    if (state == null) return;

    final data = {
      'shipped': state.shipped,
      'ndr': state.ndr,
      'out_for_delivery': state.outForDelivery,
      'returned': state.returned,
      'delivered': state.delivered,
      'processed': state.processed,
      'channel': state.channel,
      'manual': state.manual,
      key: value,
    };

    await ref
        .read(buyerCommunicationProvider.notifier)
        .updateWhatsappSmsConfig(data);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Legacy providers for UI logic
    final volume = ref.watch(monthlyVolumeProvider);
    final monthlyCost = ref.watch(estimatedMonthlyCostProvider);

    // New state from API Notifier
    final state = ref.watch(buyerCommunicationProvider);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.lightGreen,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Buyer Communication',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          centerTitle: false,
        ),
        body: state.when(
          loading: () => const Center(child: ThreeDotsLoader()),
          error: (error, _) => Center(child: ErrorCard(onRetry: () => ref.invalidate(buyerCommunicationProvider))),
          data: (data) => SingleChildScrollView(
            child: Container(
              color: const Color(0xFFF8F8F8),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    _buildHeaderSection(),
                    const SizedBox(height: 24),

                    // Read Rate & Cost Card
                    _buildMetricsCard(
                      data.smsCharge?.manualCharge.toString() ?? '0.84',
                    ),
                    const SizedBox(height: 24),

                    // Demo Section
                    _buildDemoSection(),
                    const SizedBox(height: 24),

                    // Benefits Section
                    _buildBenefitsSection(),
                    const SizedBox(height: 24),

                    // Pricing Section
                    _buildPricingSection(
                      volume,
                      monthlyCost,
                      data.smsCharge?.statusCharge ?? '0.84',
                      data.enabled,
                    ),
                    const SizedBox(height: 32),

                    // Notifications Section
                    if (data.enabled)
                      _buildNotificationsSection(
                        data.whatsappConfig!,
                        data.smsCharge?.channelCharge ?? '0.84',
                        data.smsCharge?.manualCharge ?? '0.84',
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Supercharge Your Customer Communication',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.5,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Leverage WhatsApp's 94% read rate for instant,\neffective updates",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Colors.grey[600],
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsCard(String cost) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Read Rate',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[700],
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '94%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF00A651),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unparalleled message visibility',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                      height: 1.4,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
            Container(width: 1, height: 120, color: Colors.grey[200]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cost per Message',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[700],
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹$cost*',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF5B5BFF),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Affordable, high-impact communication',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                        height: 1.4,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Try It Now',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(width: 8),
                // Image.asset(
                //   'assets/whatsapp_icon.png',
                //   width: 24,
                //   height: 24,
                //   color: const Color(0xFF25D366),
                // ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _whatsappController,
              decoration: InputDecoration(
                hintText: 'Your Whatsapp Number',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[400],
                  fontSize: 16,
                  letterSpacing: -0.2,
                ),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF00A651),
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isDemoLoading
                    ? null
                    : () async {
                        if (_whatsappController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a WhatsApp number'),
                            ),
                          );
                          return;
                        }
                        setState(() => _isDemoLoading = true);
                        try {
                          final result = await ref
                              .read(buyerCommunicationProvider.notifier)
                              .sendWhatsappDemo(_whatsappController.text);
                          if (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Demo message sent successfully!',
                                ),
                                backgroundColor: Color(0xFF00A651),
                              ),
                            );
                            _whatsappController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to send message!'),
                                backgroundColor: Color(0xFF00A651),
                              ),
                            );
                            _whatsappController.clear();
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isDemoLoading = false);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A651),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isDemoLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withOpacity(0.7),
                          ),
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Get Demo Message',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How is WhatsApp Communication helping you?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 20),
            _buildBenefitItem(
              icon: '😊',
              title: 'Increase customer delight',
              description: 'Send real-time information to the buyer',
            ),
            const SizedBox(height: 18),
            _buildBenefitItem(
              icon: '⚡',
              title: 'Easy and on-time delivery',
              description:
                  'With Brand information, make the delivery process smooth',
            ),
            const SizedBox(height: 18),
            _buildBenefitItem(
              icon: '🤝',
              title: 'Decrease customer queries',
              description:
                  'Due to increase in visibility of shipment information',
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/buyerCommunication/whatsapp_image.png',
                  fit: BoxFit.fitHeight,
                  height: 320,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem({
    required String icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00A651),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                  height: 1.4,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPricingSection(
    int volume,
    double monthlyCost,
    String costStr,
    bool? active,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cost per message',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                      letterSpacing: -0.2,
                    ),
                  ),
                  Text(
                    '₹$costStr*',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF00A651),
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Estimated Monthly Volume',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 16),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 6,
                activeTrackColor: const Color(0xFF1976D2),
                inactiveTrackColor: Colors.grey[300],
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(
                  elevation: 4,
                  enabledThumbRadius: 12,
                ),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
              ),
              child: Slider(
                value: volume.toDouble(),
                min: 0,
                max: 10000,
                divisions: 100,
                onChanged: (value) {
                  ref
                      .read(monthlyVolumeProvider.notifier)
                      .updateVolume(value.toInt());
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${volume.toInt()} messages',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '10,000',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Estimated Monthly Cost',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${monthlyCost.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF00A651),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                ref
                    .read(buyerCommunicationProvider.notifier)
                    .toggleWhatsappSmsConfig();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFB3E5FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    (active ?? false) ? 'Deactivate' : 'Activate',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0277BD),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '*NOTE: Customise real time tracking update to share with your buyers, per status just @ ₹$costStr. To avail all statuses, pay just ₹912* per order. By Default all statuses will be selected. (Prices are exclusive of GST & Non refundable)\n*NOTE: There is a seperate charge for Channel\'s Order Confirmation notifications.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
                height: 1.5,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection(
    WhatsappConfigEntity config,
    String channelCost,
    String manualCost,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WhatsApp Notifications',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Configure which status updates you want to receive on WhatsApp',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 24),
            _buildNotificationToggle(
              icon: Icons.local_shipping_outlined,
              title: 'Processing Updates',
              description: 'Get notified when your order is being processed',
              value: config.processed,
              onChanged: (val) => _updateConfig('processed', val),
            ),
            const SizedBox(height: 16),
            _buildNotificationToggle(
              icon: Icons.send_outlined,
              title: 'Shipment Updates',
              description: 'Receive notifications when your order is shipped',
              value: config.shipped,
              onChanged: (val) => _updateConfig('shipped', val),
            ),
            const SizedBox(height: 16),
            _buildNotificationToggle(
              icon: Icons.local_shipping_outlined,
              title: 'Out for Delivery',
              description: 'Know when your package is out for delivery',
              value: config.outForDelivery,
              onChanged: (val) => _updateConfig('out_for_delivery', val),
            ),
            const SizedBox(height: 16),
            _buildNotificationToggle(
              icon: Icons.warning_amber_outlined,
              title: 'Non-Delivery Reports',
              description: 'Get notified when delivery attempts fail',
              value: config.ndr,
              onChanged: (val) => _updateConfig('ndr', val),
            ),
            const SizedBox(height: 16),
            _buildNotificationToggle(
              icon: Icons.done_all_outlined,
              title: 'Delivery Confirmation',
              description: 'Receive confirmation when package is delivered',
              value: config.delivered,
              onChanged: (val) => _updateConfig('delivered', val),
            ),
            const SizedBox(height: 16),
            _buildNotificationToggle(
              icon: Icons.assignment_return_outlined,
              title: 'Return Updates',
              description: 'Get notifications about returned packages',
              value: config.returned,
              onChanged: (val) => _updateConfig('returned', val),
            ),
            const SizedBox(height: 16),
            _buildNotificationToggle(
              icon: Icons.storefront_outlined,
              title: 'Channel Confirmation ( ₹ $channelCost* per order)',
              description:
                  'Get notifications about your Shopify orders confirmation',
              value: config.channel,
              onChanged: (val) => _updateConfig('channel', val),
            ),
            const SizedBox(height: 16),
            _buildNotificationToggle(
              icon: Icons.done_outline,
              title: 'Manual Confirmation ( ₹ $manualCost* per order)',
              description:
                  'Get notifications about your Manual orders confirmation',
              value: config.manual,
              onChanged: (val) => _updateConfig('manual', val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationToggle({
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, size: 28, color: const Color(0xFF1976D2)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF1976D2),
          inactiveThumbColor: Colors.grey[400],
          inactiveTrackColor: Colors.grey[300],
        ),
      ],
    );
  }
}
