import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/businessTools/presentation/state/shipping_label_notifier.dart';
import 'package:sharkship/features/businessTools/presentation/widgets/shipping_label.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class ShippingLabelDemoPage extends ConsumerWidget {
  const ShippingLabelDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(shippingLabelProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Shipping Label Customization',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        elevation: 1,
        backgroundColor: AppColors.scaffoldBg,
      ),
      body: asyncState.when(
        loading: () => const Center(child: ThreeDotsLoader()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  "Something went wrong",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(shippingLabelProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (labelState) => _ShippingLabelBody(labelState: labelState),
      ),
    );
  }
}

class _ShippingLabelBody extends ConsumerWidget {
  final ShippingLabelState labelState;

  const _ShippingLabelBody({required this.labelState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(shippingLabelProvider.notifier);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleItem(
              context,
              label: 'RTO Visibility',
              description: 'Show RTO details on the shipping label',
              value: labelState.rtoVisibility,
              onChanged: notifier.toggleRtoVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'Sharkship Visibility',
              description: 'Display powered by Sharkship on the shipping label',
              value: labelState.sharkshipVisibility,
              onChanged: notifier.toggleSharkshipVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'Logo Visibility',
              description: 'Display your brand logo on the shipping label.',
              value: labelState.logoVisibility,
              onChanged: notifier.toggleLogoVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'GST Visibility',
              description: 'Display your GST number on the shipping label.',
              value: labelState.gstVisibility,
              onChanged: notifier.toggleGstVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'Client Visibility',
              description: 'Display client order ID on the shipping label.',
              value: labelState.clientVisibility,
              onChanged: notifier.toggleClientVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'SKU Visibility',
              description: 'Display SKU number on the shipping label.',
              value: labelState.skuVisibility,
              onChanged: notifier.toggleSkuVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'Phone Visibility',
              description:
                  'Display Customer phone number on the shipping label.',
              value: labelState.phoneVisibility,
              onChanged: notifier.togglePhoneVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'Store Name Visibility',
              description: 'Show Custom store name on the shipping label.',
              value: labelState.alterName,
              onChanged: notifier.toggleAlterName,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'Amount Visibility',
              description: 'Display the amount on the shipping label.',
              value: labelState.isAmountVisible,
              onChanged: notifier.toggleAmountVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'Table Visibility',
              description: 'Display the table on the shipping label.',
              value: labelState.tableVisibility,
              onChanged: notifier.toggleTableVisibility,
            ),
            const SizedBox(height: 15),
            _buildToggleItem(
              context,
              label: 'RTO Phone Visibility',
              description: 'Display RTO phone number on the shipping label.',
              value: labelState.rtoPhoneVisibility,
              onChanged: notifier.toggleRtoPhoneVisibility,
            ),
            const SizedBox(height: 15),
            _buildDropdownItem(
              context,
              label: 'Label Size',
              description: 'Select the dimensions for your shipping label.',
              value: labelState.labelSize,
              options: [
                {'label': 'Standard', 'value': 'STANDARD'},
                {'label': 'Thermal', 'value': 'THERMAL'},
                {'label': 'Four In One', 'value': '4x4'},
              ],
              onChanged: (val) => notifier.updateLabelSize(val ?? 'STANDARD'),
            ),
            const SizedBox(height: 15),
            if (labelState.alterName) ...[
              Text(
                'Business Name',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              _AlterNameField(
                initialValue: labelState.newName,
                onChanged: notifier.updateNewName,
              ),
            ],
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Row(
                children: [
                  Expanded(
                    child: GradientButton(
                      text: 'Preview',
                      onTap: () {
                        final controller = _buildControllerFromState(
                          labelState,
                        );
                        context.push(
                          Routes.SHIPPING_LABEL_PREVIEW,
                          extra: controller,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: labelState.isSubmitting
                        ? const Center(child: ThreeDotsLoader())
                        : GradientButton(
                            text: 'Submit',
                            onTap: () => notifier.submitConfig(context),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem(
    BuildContext context, {
    required String label,
    required String description,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  softWrap: true,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color.fromARGB(255, 114, 114, 114),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.blue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  EnhancedShippingLabelController _buildControllerFromState(
    ShippingLabelState s,
  ) {
    final controller = EnhancedShippingLabelController();
    controller.rtoVisibility = s.rtoVisibility;
    controller.sharkshipVisibility = s.sharkshipVisibility;
    controller.logoVisibility = s.logoVisibility;
    controller.gstVisibility = s.gstVisibility;
    controller.clientVisibility = s.clientVisibility;
    controller.skuVisibility = s.skuVisibility;
    controller.alterName = s.alterName;
    controller.phoneVisibility = s.phoneVisibility;
    controller.rtoPhoneVisibility = s.rtoPhoneVisibility;
    controller.tableVisibility = s.tableVisibility;
    controller.isAmountVisible = s.isAmountVisible;
    controller.labelSize = s.labelSize;
    controller.newNameController.text = s.newName;
    return controller;
  }

  Widget _buildDropdownItem(
    BuildContext context, {
    required String label,
    required String description,
    required String value,
    required List<Map<String, String>> options,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color.fromARGB(255, 114, 114, 114),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: DropdownButton<String>(
                  value: value,
                  underline: const SizedBox(),
                  items: options.map((opt) {
                    return DropdownMenuItem<String>(
                      value: opt['value'],
                      child: Text(
                        opt['label']!,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontSize: 13),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlterNameField extends StatefulWidget {
  final String initialValue;
  final void Function(String) onChanged;

  const _AlterNameField({required this.initialValue, required this.onChanged});

  @override
  State<_AlterNameField> createState() => _AlterNameFieldState();
}

class _AlterNameFieldState extends State<_AlterNameField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Enter business name',
        hintText: 'Business name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        prefixIcon: const Icon(Icons.business),
      ),
      onChanged: widget.onChanged,
    );
  }
}

/// Enhanced Controller with reactive state
class EnhancedShippingLabelController extends ShippingLabelController
    with ChangeNotifier {
  bool _logoVisibility = true;
  bool _phoneVisibility = false;
  bool _isAmountVisible = true;
  bool _clientVisibility = false;
  bool _tableVisibility = true;
  bool _skuVisibility = true;
  bool _rtoVisibility = true;
  bool _rtoPhoneVisibility = true;
  bool _gstVisibility = true;
  bool _sharkshipVisibility = true;
  bool _alterName = false;

  @override
  bool get logoVisibility => _logoVisibility;
  set logoVisibility(bool value) {
    if (_logoVisibility != value) {
      _logoVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get phoneVisibility => _phoneVisibility;
  set phoneVisibility(bool value) {
    if (_phoneVisibility != value) {
      _phoneVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get isAmountVisible => _isAmountVisible;
  set isAmountVisible(bool value) {
    if (_isAmountVisible != value) {
      _isAmountVisible = value;
      notifyListeners();
    }
  }

  @override
  bool get clientVisibility => _clientVisibility;
  set clientVisibility(bool value) {
    if (_clientVisibility != value) {
      _clientVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get tableVisibility => _tableVisibility;
  set tableVisibility(bool value) {
    if (_tableVisibility != value) {
      _tableVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get skuVisibility => _skuVisibility;
  set skuVisibility(bool value) {
    if (_skuVisibility != value) {
      _skuVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get rtoVisibility => _rtoVisibility;
  set rtoVisibility(bool value) {
    if (_rtoVisibility != value) {
      _rtoVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get rtoPhoneVisibility => _rtoPhoneVisibility;
  set rtoPhoneVisibility(bool value) {
    if (_rtoPhoneVisibility != value) {
      _rtoPhoneVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get gstVisibility => _gstVisibility;
  set gstVisibility(bool value) {
    if (_gstVisibility != value) {
      _gstVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get sharkshipVisibility => _sharkshipVisibility;
  set sharkshipVisibility(bool value) {
    if (_sharkshipVisibility != value) {
      _sharkshipVisibility = value;
      notifyListeners();
    }
  }

  @override
  bool get alterName => _alterName;
  set alterName(bool value) {
    if (_alterName != value) {
      _alterName = value;
      notifyListeners();
    }
  }

  String _labelSize = 'STANDARD';
  String get labelSize => _labelSize;
  set labelSize(String value) {
    if (_labelSize != value) {
      _labelSize = value;
      notifyListeners();
    }
  }
}
