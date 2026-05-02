import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/calculator_notifier.dart';
import 'shipping_rate_result_screen.dart';

class ShipmentRateCalculator extends ConsumerStatefulWidget {
  const ShipmentRateCalculator({super.key});

  @override
  ConsumerState<ShipmentRateCalculator> createState() =>
      _ShipmentRateCalculatorState();
}

class _ShipmentRateCalculatorState
    extends ConsumerState<ShipmentRateCalculator> {
  final _formKey = GlobalKey<FormState>();

  final _sourceController = TextEditingController();
  final _destController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _priceController = TextEditingController();

  String _paymentMode = 'COD';
  String _serviceType = 'PAN_INDIA';

  @override
  void dispose() {
    _sourceController.dispose();
    _destController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(calculatorProvider.notifier);

    await notifier.calculate(
      source: _sourceController.text,
      destination: _destController.text,
      paymentType: _paymentMode,
      weight: double.tryParse(_weightController.text) ?? 0.0,
      productValue: double.tryParse(_priceController.text) ?? 0.0,
      length: double.tryParse(_lengthController.text) ?? 0.0,
      width: double.tryParse(_widthController.text) ?? 0.0,
      height: double.tryParse(_heightController.text) ?? 0.0,
      serviceType: _serviceType,
      provider: 'SHARKSHIP',
    );

    if (mounted) {
      final state = ref.read(calculatorProvider);
      state.whenData((rates) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShippingRateResultScreen(rates: rates),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calculatorProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title:  Text(
          'Shipping Rate Calculator',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Source Pin Code'),
              _buildTextField(
                _sourceController,
                'Enter Source Pin Code',
                isPincode: true,
              ),

              _buildLabel('Destination Pin Code'),
              _buildTextField(
                _destController,
                'Enter Destination Pin Code',
                isPincode: true,
              ),

              _buildLabel('Package Dimensions'),
              Column(
                children: [
                  Container(
                    child: _buildDimensionField(
                      _lengthController,
                      'Length',
                      'CM',
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    child: _buildDimensionField(
                      _widthController,
                      'Width',
                      'CM',
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    child: _buildDimensionField(
                      _heightController,
                      'Height',
                      'CM',
                    ),
                  ),
                ],
              ),

              _buildLabel('Package Weight'),
              _buildDimensionField(
                _weightController,
                'Enter Package Weight',
                'KG',
              ),

              _buildLabel('Product Price'),
              _buildTextField(
                _priceController,
                'Enter Product Price',
                isNumber: true,
              ),

              _buildLabel('Select Payment Mode'),
              Row(
                children: [
                  _buildRadioButton(
                    'COD',
                    'COD',
                    _paymentMode,
                    (val) => setState(() => _paymentMode = val!),
                  ),
                  const SizedBox(width: 20),
                  _buildRadioButton(
                    'Prepaid',
                    'Prepaid',
                    _paymentMode,
                    (val) => setState(() => _paymentMode = val!),
                  ),
                ],
              ),

              _buildLabel('Select Service Type'),
              Row(
                children: [
                  _buildRadioButton(
                    'PAN India',
                    'PAN_INDIA',
                    _serviceType,
                    (val) => setState(() => _serviceType = val!),
                  ),
                  const SizedBox(width: 20),
                  _buildRadioButton(
                    'SDD',
                    'SDD',
                    _serviceType,
                    (val) => setState(() => _serviceType = val!),
                  ),
                  const SizedBox(width: 20),
                  _buildRadioButton(
                    'NDD',
                    'NDD',
                    _serviceType,
                    (val) => setState(() => _serviceType = val!),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              state.isLoading
                  ? const Center(child: ThreeDotsLoader())
                  : GradientButton(
                      onTap: _calculate,
                      text: 'Calculate Shipment Rate',
                    ),

              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Error: ${state.error}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          Text(
            ' *',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.orange,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool isPincode = false,
    bool isNumber = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: (isPincode || isNumber)
            ? TextInputType.number
            : TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade400,
              ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          if (isPincode && value.length != 6) return 'Invalid pincode';
          return null;
        },
      ),
    );
  }

  Widget _buildDimensionField(
    TextEditingController controller,
    String hint,
    String unit,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade400,
                    ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Required';
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              unit,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButton(
    String label,
    String value,
    String groupValue,
    Function(String?) onChanged,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.primaryBlue,
        ),
        Text(label),
      ],
    );
  }
}
