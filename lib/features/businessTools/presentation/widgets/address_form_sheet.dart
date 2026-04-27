import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/businessTools/presentation/state/manage_address_notifier.dart';
import 'package:sharkship/features/orders/domain/entities/order_address_entity.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';

class AddressFormSheet extends ConsumerStatefulWidget {
  final OrderAddressEntity? address;
  const AddressFormSheet({super.key, this.address});

  @override
  ConsumerState<AddressFormSheet> createState() => AddressFormSheetState();
}

class AddressFormSheetState extends ConsumerState<AddressFormSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController phone;
  late final TextEditingController address1;
  late final TextEditingController address2;
  late final TextEditingController landmark;
  late final TextEditingController pin;
  late final TextEditingController city;
  late final TextEditingController stateCtrl;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.address?.name);
    phone = TextEditingController(text: widget.address?.phoneNo);
    address1 = TextEditingController(text: widget.address?.addressLane1);
    address2 = TextEditingController(text: widget.address?.addressLane2);
    landmark = TextEditingController(text: widget.address?.landmark);
    pin = TextEditingController(text: widget.address?.pin?.toString());
    city = TextEditingController(text: widget.address?.city);
    stateCtrl = TextEditingController(text: widget.address?.state);
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address1.dispose();
    address2.dispose();
    landmark.dispose();
    pin.dispose();
    city.dispose();
    stateCtrl.dispose();
    super.dispose();
  }

  InputDecoration _input(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF3F4F6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool required = false,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style: const TextStyle(fontWeight: FontWeight.w600),
            children: required
                ? const [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: required
              ? (v) => v == null || v.isEmpty ? 'Required' : null
              : null,
          decoration: _input("Enter $label"),
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final addressState = ref.watch(manageAddressProvider);
    final isEdit = widget.address != null;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// drag handle
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          /// header
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 8),
              Text(
                isEdit ? "Edit Address" : "Add New Address",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isEdit ? "Update your Warehouse Location" : "Set Up a New Warehouse Location",
              style: const TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 16),

          /// form
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _field("Name", name, required: true),
                    _field("Phone Number", phone, required: true),
                    _field("Address Line 1", address1, required: true),
                    _field("Address Line 2", address2),
                    _field("Landmark", landmark),
                    _field(
                      "Pin",
                      pin,
                      required: true,
                      onChanged: (value) async {
                        if (value.length == 6) {
                          final details = await ref
                              .read(manageAddressProvider.notifier)
                              .getPinDetails(value);
                          if (details != null) {
                            city.text = details.city;
                            stateCtrl.text = details.state;
                          }
                        }
                      },
                    ),
                    _field("City", city, required: true),
                    _field("State", stateCtrl, required: true),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          /// button
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            child: GradientButton(
              onTap: addressState.isLoading ? null : _submit,
              text: isEdit ? "Update Address" : "Save Address",
              child: addressState.isLoading
                ? const Center(
                    child: ThreeDotsLoader(
                      size: 8,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white70,
                    ),
                  )
                : null,
            ),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final isEdit = widget.address != null;
    final payload = {
      "Pin": pin.text,
      "address_lane1": address1.text,
      "address_lane2": address2.text,
      "blitz_address_id": null,
      "blueDart_express_address_id": null,
      "blueDart_surface_address_id": null,
      "city": city.text,
      "delhivery_express_address_id": null,
      "delhivery_integration_2kg_address_id": null,
      "delhivery_integration_5kg_address_id": null,
      "delhivery_integration_10kg_address_id": null,
      "delhivery_integration_20kg_address_id": null,
      "delhivery_surface_address_id": null,
      "dtdc_express_address_id": null,
      "dtdc_surface_address_id": null,
      "expressfly_address_id": null,
      "landmark": landmark.text,
      "name": name.text,
      "phone_no": phone.text,
      "shadowfax_surface_address_id": null,
      "shiprocket_address_id": null,
      "state": stateCtrl.text,
    };

    if (isEdit) {
      await ref
          .read(manageAddressProvider.notifier)
          .editAddress(widget.address!.id!, payload);
    } else {
      await ref.read(manageAddressProvider.notifier).addNewAddress(payload);
    }

    if (!mounted) return;
    
    final newState = ref.read(manageAddressProvider);
    if (newState.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(newState.error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!newState.isLoading) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEdit
              ? "Address updated successfully"
              : "Address added successfully"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
