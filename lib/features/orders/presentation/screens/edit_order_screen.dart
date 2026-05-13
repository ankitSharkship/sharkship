import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../../domain/entities/order_entity.dart';
import '../state/single_order_ship_notifier.dart';

// ---------------------------------------------------------------------------
// Product categories (matches create-order screen)
// ---------------------------------------------------------------------------
const _kCategories = [
  'Apparels and Accessories',
  'Home Decor',
  'Personal Care',
  'Fashion',
  'Electronics',
  'Bags',
  'Fitness, Gym Equipments and Accessories',
  'Health, Fitness and Hygiene',
  'Jewellery',
  'Eyewear',
  'Cosmetics',
  'Bedsheet and furnishing',
  'Uncategorised',
];

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------
class EditOrderScreen extends ConsumerStatefulWidget {
  final OrderEntity order;
  const EditOrderScreen({super.key, required this.order});

  @override
  ConsumerState<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends ConsumerState<EditOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  // We keep local TextEditingControllers so the fields stay in sync
  // when the user types; the notifier is the source of truth on submit.
  late final Map<String, TextEditingController> _ctrl;

  @override
  void initState() {
    super.initState();
    final o = widget.order;
    _ctrl = {
      'customerName': TextEditingController(text: o.customer.name ?? ''),
      'customerMobile': TextEditingController(text: o.customer.mobileNo),
      'lane1': TextEditingController(text: o.deliveryAddress.addressLane1),
      'lane2': TextEditingController(text: o.deliveryAddress.addressLane2),
      'landmark': TextEditingController(text: o.deliveryAddress.landmark ?? ''),
      'pin': TextEditingController(text: o.deliveryAddress.pin.toString()),
      'city': TextEditingController(text: o.deliveryAddress.city),
      'state': TextEditingController(text: o.deliveryAddress.state),
      'codAmount': TextEditingController(text: o.codAmount.toString()),
      'clientOrderId': TextEditingController(text: o.clientOrderId ?? ''),
      'length': TextEditingController(text: o.shipmentLengthInCms.toString()),
      'width': TextEditingController(text: o.shipmentWidthInCms.toString()),
      'height': TextEditingController(text: o.shipmentHeightInCms.toString()),
      'weight': TextEditingController(text: o.productWeightInKg),
    };
  }

  @override
  void dispose() {
    for (final c in _ctrl.values) c.dispose();
    super.dispose();
  }

  SingleOrderShipNotifier get _notifier =>
      ref.read(singleOrderShipProvider(widget.order).notifier);

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    // Push text-field values into notifier before saving
    _notifier
      ..updateCustomerName(_ctrl['customerName']!.text)
      ..updateCustomerMobile(_ctrl['customerMobile']!.text)
      ..updateAddressLane1(_ctrl['lane1']!.text)
      ..updateAddressLane2(_ctrl['lane2']!.text)
      ..updateLandmark(_ctrl['landmark']!.text)
      ..updatePin(_ctrl['pin']!.text)
      ..updateCity(_ctrl['city']!.text)
      ..updateStateField(_ctrl['state']!.text)
      ..updateCodAmount(_ctrl['codAmount']!.text)
      ..updateClientOrderId(_ctrl['clientOrderId']!.text)
      ..updateLength(_ctrl['length']!.text)
      ..updateWidth(_ctrl['width']!.text)
      ..updateHeight(_ctrl['height']!.text)
      ..updateWeight(_ctrl['weight']!.text);

    final success = await _notifier.editOrder();
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order updated successfully')),
      );
      Navigator.of(context).pop();
    } else {
      final error = ref.read(singleOrderShipProvider(widget.order)).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to update order'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(singleOrderShipProvider(widget.order));
    final isSaving = state.isSaving;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Edit Order #${widget.order.id}',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.scaffoldBg,
        centerTitle: false,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          children: [
            _CustomerSection(ctrl: _ctrl),
            const SizedBox(height: 16),
            _OrderDetailsSection(
              order: widget.order,
              ctrl: _ctrl,
              state: state,
              notifier: _notifier,
            ),
            const SizedBox(height: 16),
            _ShipmentSection(ctrl: _ctrl),
          ],
        ),
      ),
      bottomNavigationBar: _SaveBar(isSaving: isSaving, onSave: _save),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1 – Customer Details
// ---------------------------------------------------------------------------
class _CustomerSection extends StatelessWidget {
  final Map<String, TextEditingController> ctrl;
  const _CustomerSection({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: "Customer's Details:",
      children: [
        _Field(
          label: 'Customer Name',
          required: true,
          controller: ctrl['customerName']!,
          validator: _required,
        ),
        _Field(
          label: 'Customer Mobile No',
          required: true,
          controller: ctrl['customerMobile']!,
          keyboardType: TextInputType.phone,
          validator: _required,
        ),
        _Field(
          label: 'Address Lane 1',
          required: true,
          controller: ctrl['lane1']!,
          validator: _required,
        ),
        _Field(label: 'Address Lane 2', controller: ctrl['lane2']!),
        _Field(
          label: 'PIN Code',
          required: true,
          controller: ctrl['pin']!,
          keyboardType: TextInputType.number,
          validator: _required,
        ),
        _Field(label: 'Landmark', controller: ctrl['landmark']!),
        _Field(
          label: 'City',
          required: true,
          controller: ctrl['city']!,
          validator: _required,
        ),
        _Field(
          label: 'State',
          required: true,
          controller: ctrl['state']!,
          validator: _required,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 – Order Details
// ---------------------------------------------------------------------------
class _OrderDetailsSection extends ConsumerWidget {
  final OrderEntity order;
  final Map<String, TextEditingController> ctrl;
  final SingleOrderShipState state;
  final SingleOrderShipNotifier notifier;

  const _OrderDetailsSection({
    required this.order,
    required this.ctrl,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> onRemoveItem(int index, EditLineItem item) async {
      if (item.id == null) {
        // New item, just remove locally
        notifier.removeLineItem(index);
        return;
      }

      // Existing item, ask for confirmation
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Delete Product?'),
          content: Text(
            'Are you sure you want to permanently delete "${item.productName.isEmpty ? 'this product' : item.productName}" from this order?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        final success = await notifier.deleteLineItemPermanently(
          item.id!,
          index,
        );
        if (!context.mounted) return;
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product deleted successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error ?? 'Failed to delete product'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    return _Card(
      title: 'Order Details:',
      titleColor: AppColors.primaryBlue,
      children: [
        // Line items
        ...List.generate(state.lineItems.length, (i) {
          final item = state.lineItems[i];
          return _LineItemForm(
            index: i,
            item: item,
            canRemove: state.lineItems.length > 1,
            onRemove: () => onRemoveItem(i, item),
            onChanged: (updated) =>
                notifier.updateLineItemField(i, (_) => updated),
          );
        }),

        // Add more
        TextButton.icon(
          onPressed: notifier.addLineItem,
          icon: const Icon(Icons.add, color: AppColors.primaryBlue),
          label: const Text(
            'Add More Products',
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const Divider(height: 24),

        // Payment mode
        _RadioRow<String>(
          label: 'Select Payment Mode:',
          options: const ['COD', 'PREPAID'],
          selected:
              state.paymentMode == "COD" || state.paymentMode == "PARTIAL_COD"
              ? "COD"
              : "PREPAID",
          labelBuilder: (v) => (v == 'COD') ? 'COD' : 'Prepaid',
          onChanged: notifier.updatePaymentMode,
        ),

        const SizedBox(height: 8),

        // Service type
        _RadioRow<String>(
          label: 'Select Service Type:',
          options: const ['PAN_INDIA', 'SDD', 'NDD'],
          selected: state.serviceType,
          labelBuilder: (v) => v == 'PAN_INDIA' ? 'PAN India' : v,
          onChanged: notifier.updateServiceType,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3 – Shipment Details
// ---------------------------------------------------------------------------
class _ShipmentSection extends StatelessWidget {
  final Map<String, TextEditingController> ctrl;
  const _ShipmentSection({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: 'Shipment Details:',
      titleColor: AppColors.primaryBlue,
      children: [
        _Field(
          label: 'COD Amount',
          required: true,
          controller: ctrl['codAmount']!,
          keyboardType: TextInputType.number,
          validator: _required,
        ),
        _Field(
          label: 'Client ID (Optional)',
          controller: ctrl['clientOrderId']!,
        ),
        _Field(
          label: 'Length (cm)',
          required: true,
          controller: ctrl['length']!,
          keyboardType: TextInputType.number,
          validator: _required,
        ),
        _Field(
          label: 'Width (cm)',
          required: true,
          controller: ctrl['width']!,
          keyboardType: TextInputType.number,
          validator: _required,
        ),
        _Field(
          label: 'Height (cm)',
          required: true,
          controller: ctrl['height']!,
          keyboardType: TextInputType.number,
          validator: _required,
        ),
        _Field(
          label: 'Weight (kg)',
          required: true,
          controller: ctrl['weight']!,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: _required,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Line item form – used for both existing and new products
// ---------------------------------------------------------------------------
class _LineItemForm extends StatefulWidget {
  final int index;
  final EditLineItem item;
  final bool canRemove;
  final VoidCallback onRemove;
  final ValueChanged<EditLineItem> onChanged;

  const _LineItemForm({
    required this.index,
    required this.item,
    required this.canRemove,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  State<_LineItemForm> createState() => _LineItemFormState();
}

class _LineItemFormState extends State<_LineItemForm> {
  late final TextEditingController _name;
  late final TextEditingController _price;
  late final TextEditingController _qty;
  late final TextEditingController _sku;
  late final TextEditingController _tax;
  String? _category;

  @override
  void initState() {
    super.initState();
    final it = widget.item;
    _name = TextEditingController(text: it.productName);
    _price = TextEditingController(text: it.productPrice);
    _qty = TextEditingController(text: it.productQuantity);
    _sku = TextEditingController(text: it.sku ?? '');
    _tax = TextEditingController(text: it.taxRate ?? '');
    // Only keep the stored category if it is one of the known options;
    // otherwise leave it unset so the dropdown doesn't assert.
    _category = _kCategories.contains(it.productCategory)
        ? it.productCategory
        : null;
  }

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _qty.dispose();
    _sku.dispose();
    _tax.dispose();
    super.dispose();
  }

  void _push() => widget.onChanged(
    widget.item.copyWith(
      productName: _name.text,
      productPrice: _price.text,
      productQuantity: _qty.text,
      sku: _sku.text,
      taxRate: _tax.text.isEmpty ? null : _tax.text,
      productCategory: _category ?? '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.index > 0) const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product ${widget.index + 1}',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (widget.canRemove)
              TextButton.icon(
                onPressed: widget.onRemove,
                icon: const Icon(Icons.close, color: Colors.red, size: 16),
                label: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
          ],
        ),
        _Field(
          label: 'Product Name',
          required: true,
          controller: _name,
          validator: _required,
          onChanged: (_) => _push(),
        ),
        _Field(
          label: 'Product Price',
          required: true,
          controller: _price,
          keyboardType: TextInputType.number,
          validator: _required,
          onChanged: (_) => _push(),
        ),
        _Field(
          label: 'Product Quantity',
          required: true,
          controller: _qty,
          keyboardType: TextInputType.number,
          validator: _required,
          onChanged: (_) => _push(),
        ),
        _Field(
          label: 'Tax Rate (Optional)',
          controller: _tax,
          keyboardType: TextInputType.number,
          onChanged: (_) => _push(),
        ),
        _Field(
          label: 'SKU No. (Optional)',
          controller: _sku,
          onChanged: (_) => _push(),
        ),
        // Category dropdown
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Category',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: _inputDeco(context),
                hint: const Text('Select category'),
                isExpanded: true,
                items: _kCategories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) {
                  setState(() => _category = v);
                  _push();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Save bottom bar
// ---------------------------------------------------------------------------
class _SaveBar extends StatelessWidget {
  final bool isSaving;
  final VoidCallback onSave;
  const _SaveBar({required this.isSaving, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: isSaving ? null : onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: isSaving
              ? const ThreeDotsLoader(activeColor: Colors.white)
              : Text(
                  'Save Changes',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared card wrapper
// ---------------------------------------------------------------------------
class _Card extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final List<Widget> children;
  const _Card({required this.title, this.titleColor, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable text field
// ---------------------------------------------------------------------------
class _Field extends StatelessWidget {
  final String label;
  final bool required;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const _Field({
    required this.label,
    this.required = false,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              children: required
                  ? const [
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: _inputDeco(context),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Radio row helper
// ---------------------------------------------------------------------------
class _RadioRow<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T selected;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onChanged;

  const _RadioRow({
    required this.label,
    required this.options,
    required this.selected,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Wrap(
          children: options.map((opt) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<T>(
                  value: opt,
                  groupValue: selected,
                  onChanged: (v) => onChanged(v as T),
                  activeColor: AppColors.primaryBlue,
                ),
                GestureDetector(
                  onTap: () => onChanged(opt),
                  child: Text(labelBuilder(opt)),
                ),
                const SizedBox(width: 8),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared input decoration
// ---------------------------------------------------------------------------
InputDecoration _inputDeco(BuildContext context) => InputDecoration(
  filled: true,
  fillColor: Colors.grey.shade50,
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey.shade300),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey.shade300),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.primaryBlue),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.redAccent),
  ),
);

// ---------------------------------------------------------------------------
// Validator helpers
// ---------------------------------------------------------------------------
String? _required(String? v) =>
    (v == null || v.trim().isEmpty) ? 'This field is required' : null;
