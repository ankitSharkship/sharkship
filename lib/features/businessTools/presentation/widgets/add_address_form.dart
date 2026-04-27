import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sharkship/features/businessTools/presentation/state/manage_address_notifier.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';

class AddAddressSheet extends ConsumerStatefulWidget {
  const AddAddressSheet({super.key});

  @override
  ConsumerState<AddAddressSheet> createState() => AddAddressSheetState();
}

class AddAddressSheetState extends ConsumerState<AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phone = TextEditingController();
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final landmark = TextEditingController();
  final pin = TextEditingController();
  final city = TextEditingController();
  final stateCtrl = TextEditingController();

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
            children: const [
              Icon(Icons.location_on_outlined),
              SizedBox(width: 8),
              Text(
                "Add New Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Set Up a New Warehouse Location",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 16),

          /// form
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
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
                    const SizedBox(height: 80),
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
              onTap: () async {
                if (!_formKey.currentState!.validate()) return;

                final payload = {
                  "Pin": pin.text,
                  "address_lane1": address1.text,
                  "address_lane2": address2.text ?? "",
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
                  "landmark": landmark.text ?? "",
                  "name": name.text,
                  "phone_no": phone.text,
                  "shadowfax_surface_address_id": null,
                  "shiprocket_address_id": null,
                  "state": stateCtrl.text,
                };
                await ref
                    .read(manageAddressProvider.notifier)
                    .addNewAddress(payload);

                if (context.mounted &&
                    ref.read(manageAddressProvider).error == null) {
                  Navigator.pop(context);
                }
              },
              text: "Save Address",
              child: addressState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
