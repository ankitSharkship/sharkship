import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/orders/presentation/state/bulk_orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/create_orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/create_single_order_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/create_single_order_state.dart';
import 'package:sharkship/features/orders/presentation/widgets/create_order_tabbar.dart';
import 'package:sharkship/features/orders/presentation/widgets/create_orders_header.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class CreateOrders extends ConsumerStatefulWidget {
  const CreateOrders({super.key});
  @override
  ConsumerState<CreateOrders> createState() => _CreateOrdersState();
}

class _CreateOrdersState extends ConsumerState<CreateOrders> {
  final _createOrderFormKey = GlobalKey<FormState>();

  // Step 0: Customer Controllers
  final customerNameController = TextEditingController();
  final customerMobileNumberController = TextEditingController();
  final customerEmailController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final pinController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  // Step 1: Order Details
  PaymentMode? _paymentMode = PaymentMode.prepaid;
  ServiceType? _serviceType = ServiceType.panIndia;
  final List<ProductFormItem> _products = [ProductFormItem()];

  // Step 2: Shipment Details
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final clientIdController = TextEditingController();
  final pickupPinController = TextEditingController();

  @override
  void dispose() {
    customerNameController.dispose();
    customerMobileNumberController.dispose();
    customerEmailController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    pinController.dispose();
    cityController.dispose();
    stateController.dispose();
    lengthController.dispose();
    widthController.dispose();
    heightController.dispose();
    weightController.dispose();
    clientIdController.dispose();
    pickupPinController.dispose();
    for (var p in _products) {
      p.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(createOrdersTabProvider);
    final state = ref.watch(createSingleOrderProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const CreateOrdersHeader(),
                CreateOrderTabbar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 100,
                      top: 20,
                    ),
                    child: _buildTabContent(selectedTab, ref),
                  ),
                ),
              ],
            ),
            if (state.isLoading)
              Container(
                color: Colors.black26,
                child: const Center(child: ThreeDotsLoader()),
              ),
          ],
        ),
      ),
      bottomNavigationBar: state.step < 4 && selectedTab != 1
          ? _buildFooter()
          : null,
    );
  }

  Widget _buildFooter() {
    final state = ref.watch(createSingleOrderProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          if (state.step > 0) ...[
            Expanded(flex: 1, child: _buildSecondaryButton()),
            const SizedBox(width: 12),
          ],
          Expanded(flex: 2, child: _buildPrimaryButtonLogin()),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton() {
    final notifier = ref.read(createSingleOrderProvider.notifier);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: Color(0xFF1E88C8)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => notifier.prevStep(),
      child: Text(
        'Previous',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: const Color(0xFF1E88C8),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTabContent(int selectedTab, WidgetRef ref) {
    switch (selectedTab) {
      case 0:
        return _buildSingleOrderTab();
      case 1:
        return _buildBulkOrderTab();
      default:
        return const Center(child: Text('Bulk Upload coming soon'));
    }
  }

  Widget _buildStepProgress(int currentStep) {
    const int maxSteps = 4;
    return Row(
      children: List.generate(maxSteps, (index) {
        bool isCompleted = index < currentStep;
        bool isCurrent = index == currentStep;

        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(
              right: index == maxSteps - 1 ? 0 : 6,
              top: 20,
              bottom: 20,
            ),
            height: 12,
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFF1E88C8)
                  : (isCurrent
                        ? const Color(0xFF6EC1E4)
                        : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSingleOrderTab() {
    final state = ref.watch(createSingleOrderProvider);
    return Column(
      children: [
        _buildStepProgress(state.step),
        Form(key: _createOrderFormKey, child: _buildCurrentStepForm(state)),
      ],
    );
  }

  Widget _buildBulkOrderTab() {
    final state = ref.watch(bulkOrdersProvider);
    final notifier = ref.read(bulkOrdersProvider.notifier);
    return ElevatedFormCard(
      title: 'Create Bulk Orders',
      child: Column(
        children: [
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ), // Default style
              children: [
                const TextSpan(text: 'Note: Please refer to this '),
                TextSpan(
                  text: 'template',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      await notifier.downloadTemplate(context);
                    },
                ),
                const TextSpan(text: ' before uploading'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (state.file == null) ...[
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: state.isLoading ? null : notifier.pickFile,
                child: Text(
                  'Select File',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ] else ...[
            _buildActionCard(
              icon: Icons.check_circle,
              title: 'File Selected',
              subtitle: state.file!.path.split('/').last,
              color: Colors.green.shade50,
              iconColor: Colors.green,
              onTap: () => notifier.pickFile(),
              onTrailingTap: () => notifier.clearFile(),
            ),
          ],
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final success = await notifier.submit();
                      if (success && mounted) {
                        _showSuccessDialog();
                      } else if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to create bulk orders.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
              child: Text(
                "Create Order",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStepForm(CreateSingleOrderState state) {
    switch (state.step) {
      case 0:
        return _buildCustomerDetailsForm();
      case 1:
        return _buildOrderDetailsForm();
      case 2:
        return _buildShipmentDetailsForm();
      case 3:
        return _buildCourierForm();
      default:
        return const SizedBox();
    }
  }

  Widget _buildCustomerDetailsForm() {
    return ElevatedFormCard(
      title: 'Customer Details',
      child: Column(
        children: [
          _input(
            label: 'Customer Name *',
            hint: "Enter Customer's Name",
            controller: customerNameController,
            validator: (v) => v!.isEmpty ? 'Name is required' : null,
          ),
          const SizedBox(height: 16),
          _input(
            label: 'Customer Mobile Number *',
            hint: "Enter Customer's Mobile Number",
            controller: customerMobileNumberController,
            keyboard: TextInputType.phone,
            validator: (v) =>
                v!.length != 10 ? 'Enter valid 10-digit number' : null,
          ),
          const SizedBox(height: 16),
          _input(
            label: 'Customer Email *',
            hint: "Enter Customer's Email",
            controller: customerEmailController,
            keyboard: TextInputType.emailAddress,
            validator: (v) => !v!.contains('@') ? 'Enter valid email' : null,
          ),
          const SizedBox(height: 16),
          _input(
            label: 'Address Line 1 *',
            hint: "Enter Address Line 1",
            controller: addressLine1Controller,
            validator: (v) => v!.isEmpty ? 'Address is required' : null,
          ),
          const SizedBox(height: 16),
          _input(
            label: 'Address Line 2',
            hint: "Enter Address Line 2",
            controller: addressLine2Controller,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _input(
                  label: 'PIN *',
                  hint: "Enter PIN",
                  controller: pinController,
                  keyboard: TextInputType.number,
                  validator: (v) => v!.length != 6 ? 'Invalid PIN' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _input(
                  label: 'City *',
                  hint: "Enter City",
                  controller: cityController,
                  validator: (v) => v!.isEmpty ? 'City required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _input(
            label: 'State *',
            hint: "Enter State",
            controller: stateController,
            validator: (v) => v!.isEmpty ? 'State required' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailsForm() {
    final state = ref.watch(createSingleOrderProvider);
    return Column(
      children: [
        ElevatedFormCard(
          title: 'Order Details',
          child: Column(
            children: [
              _dropdown(
                label: 'Payment Mode *',
                hint: 'Select Payment Mode',
                value: _paymentMode?.label,
                items: PaymentMode.values.map((e) => e.label).toList(),
                onChanged: (val) {
                  setState(() {
                    _paymentMode = PaymentMode.values.firstWhere(
                      (e) => e.label == val,
                    );
                  });
                },
              ),
              const SizedBox(height: 16),
              _dropdown(
                label: 'Service Type *',
                hint: 'Select Service Type',
                value: _serviceType?.label,
                items: ServiceType.values.map((e) => e.label).toList(),
                onChanged: (val) {
                  setState(() {
                    _serviceType = ServiceType.values.firstWhere(
                      (e) => e.label == val,
                    );
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildPickupAddressSelector(state),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ElevatedFormCard(
          title: 'Product Details',
          child: Column(
            children: [
              ..._products.asMap().entries.map((entry) {
                int idx = entry.key;
                var p = entry.value;
                return _buildProductItem(idx, p);
              }),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _products.add(ProductFormItem());
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Another Product'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPickupAddressSelector(CreateSingleOrderState state) {
    final selected = state.orderDetails?.selectedPickupAddress;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pickup Address *',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showPickupAddressPopup(state),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selected != null
                        ? "${selected.name} - ${selected.addressLane1}, ${selected.city}"
                        : "Select Pickup Address",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: selected != null ? Colors.black : Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
    VoidCallback? onTrailingTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: iconColor.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
            if (onTrailingTap != null)
              IconButton(
                onPressed: onTrailingTap,
                icon: const Icon(Icons.close, size: 20),
              )
            else
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.black26,
              ),
          ],
        ),
      ),
    );
  }

  void _showPickupAddressPopup(CreateSingleOrderState state) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Select Pickup Address',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: state.availablePickupAddresses.isEmpty
                ? const Center(child: Text('No addresses found'))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.availablePickupAddresses.length,
                    itemBuilder: (context, index) {
                      final addr = state.availablePickupAddresses[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                        color: Colors.grey.shade50,
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(createSingleOrderProvider.notifier)
                                .selectPickupAddress(addr);
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  addr.name ?? 'Unnamed',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${addr.addressLane1}, ${addr.city}, ${addr.state} - ${addr.pin}",
                                ),
                                Text(
                                  "Ph: ${addr.phoneNo ?? 'N/A'}",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _buildProductItem(int index, ProductFormItem p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product #${index + 1}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (_products.length > 1)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _products.removeAt(index);
                    });
                  },
                ),
            ],
          ),
          _input(
            label: 'Product Name *',
            hint: 'Enter Product Name',
            controller: p.nameController,
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _input(
                  label: 'Price *',
                  hint: '0.0',
                  controller: p.priceController,
                  keyboard: TextInputType.number,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _input(
                  label: 'Qty *',
                  hint: '1',
                  controller: p.qtyController,
                  keyboard: TextInputType.number,
                  validator: (v) =>
                      int.tryParse(v ?? '') == null ? 'Invalid' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _dropdown(
            label: 'Category *',
            hint: 'Select Category',
            value: p.category?.label,
            items: CategoryType.values.map((e) => e.label).toList(),
            onChanged: (val) {
              setState(() {
                p.category = CategoryType.values.firstWhere(
                  (e) => e.label == val,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShipmentDetailsForm() {
    return ElevatedFormCard(
      title: 'Shipment Details',
      child: Column(
        children: [
          _input(
            label: 'Actual Weight (kg) *',
            hint: 'Enter weight in kg',
            controller: weightController,
            keyboard: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _input(
                  label: 'Length (cm) *',
                  hint: 'L',
                  controller: lengthController,
                  keyboard: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _input(
                  label: 'Width (cm) *',
                  hint: 'W',
                  controller: widthController,
                  keyboard: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _input(
                  label: 'Height (cm) *',
                  hint: 'H',
                  controller: heightController,
                  keyboard: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _input(
            label: 'Pickup Pin',
            hint: 'Enter pickup pin if different',
            controller: pickupPinController,
            keyboard: TextInputType.number,
          ),
          const SizedBox(height: 16),
          _input(
            label: 'Client ID (Optional)',
            hint: 'Internal Reference',
            controller: clientIdController,
          ),
        ],
      ),
    );
  }

  Widget _buildCourierForm() {
    final state = ref.watch(createSingleOrderProvider);
    final rates = state.courierDetails?.availableRates ?? [];

    return ElevatedFormCard(
      title: 'Select Courier',
      child: Column(
        children: [
          if (rates.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'No shipping rates available for the selected criteria.',
              ),
            ),
          ...rates.map((rate) {
            bool isSelected = state.courierDetails?.selectedRate?.id == rate.id;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF1E88C8)
                      : Colors.grey.shade200,
                  width: isSelected ? 2 : 1,
                ),
                color: isSelected
                    ? const Color(0xFF1E88C8).withOpacity(0.05)
                    : Colors.white,
              ),
              child: ListTile(
                onTap: () => ref
                    .read(createSingleOrderProvider.notifier)
                    .selectRate(rate),
                leading: rate.logo != null && rate.logo!.isNotEmpty
                    ? Image.network(
                        rate.logo!,
                        width: 40,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.local_shipping),
                      )
                    : const Icon(Icons.local_shipping),
                title: Text(
                  rate.carrier,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${rate.courierType} | ${rate.serviceType}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Text(
                  "₹${rate.rate}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E88C8),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

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
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboard,
          obscureText: obscureText,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF1E88C8)),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButtonLogin() {
    final state = ref.watch(createSingleOrderProvider);
    final notifier = ref.read(createSingleOrderProvider.notifier);

    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6EC1E4), Color(0xFF1E88C8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: state.isLoading
            ? null
            : () async {
                if (_createOrderFormKey.currentState!.validate()) {
                  _saveCurrentStepToState(state.step);
                  if (state.step < 3) {
                    final success = await notifier.nextStep();
                    if (!success && state.step == 2) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Failed to fetch shipping rates. Please check address details.',
                            ),
                          ),
                        );
                      }
                    }
                  } else {
                    final success = await notifier.submitOrder();
                    if (success && mounted) {
                      _showSuccessDialog();
                    } else if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to create order.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
        child: Text(
          state.step == 3 ? 'Confirm Order' : 'Next',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Order Created!',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Your order has been successfully placed.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF1E88C8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back from CreateOrders
              },
              child: Text(
                'Back to Home',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveCurrentStepToState(int step) {
    final notifier = ref.read(createSingleOrderProvider.notifier);
    if (step == 0) {
      notifier.updateCustomerDetails(
        CustomerDetails(
          customerName: customerNameController.text,
          customerMobileNumber: customerMobileNumberController.text,
          customerEmail: customerEmailController.text,
          addressLine1: addressLine1Controller.text,
          addressLine2: addressLine2Controller.text,
          pin: pinController.text,
          city: cityController.text,
          state: stateController.text,
        ),
      );
    } else if (step == 1) {
      notifier.updateOrderDetails(
        OrderDetails(
          productsList: _products
              .map(
                (p) => ProductDetails(
                  productName: p.nameController.text,
                  productPrice: p.priceController.text,
                  productQuantity: int.tryParse(p.qtyController.text) ?? 1,
                  category: p.category ?? CategoryType.apparelsAndAccessories,
                ),
              )
              .toList(),
          paymentMode: _paymentMode ?? PaymentMode.prepaid,
          serviceType: _serviceType ?? ServiceType.panIndia,
          selectedPickupAddress: ref
              .read(createSingleOrderProvider)
              .orderDetails
              ?.selectedPickupAddress,
        ),
      );
    } else if (step == 2) {
      notifier.updateShipmentDetails(
        ShipmentDetails(
          length: lengthController.text,
          width: widthController.text,
          height: heightController.text,
          actualWeight: weightController.text,
          clientId: clientIdController.text,
          pickupPin: pickupPinController.text,
        ),
      );
    }
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
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(
            hint,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400),
          ),
          isExpanded: true,
          validator: validator,
          icon: const Icon(Icons.expand_more_rounded, size: 20),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1E88C8)),
            ),
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: Theme.of(context).textTheme.bodyMedium),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class ProductFormItem {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController(text: '1');
  CategoryType? category;

  void dispose() {
    nameController.dispose();
    priceController.dispose();
    qtyController.dispose();
  }
}

class ElevatedFormCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Color accentColor;

  const ElevatedFormCard({
    super.key,
    required this.title,
    required this.child,
    this.accentColor = const Color(0xFF1E88C8),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3436),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(padding: const EdgeInsets.all(20.0), child: child),
        ),
      ],
    );
  }
}
