import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/businessTools/presentation/state/manage_address_notifier.dart';
import 'package:sharkship/features/businessTools/presentation/widgets/address_form_sheet.dart';
import 'package:sharkship/features/orders/domain/entities/order_address_entity.dart';
import 'package:sharkship/features/orders/presentation/state/courier_settings_notifier.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class AddressScreen extends ConsumerStatefulWidget {
  const AddressScreen({super.key});

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showAddressFormSheet(
    BuildContext context, {
    OrderAddressEntity? address,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.lightBlueBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isDismissible: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      builder: (_) => AddressFormSheet(address: address),
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(manageAddressProvider);

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      appBar: AppBar(
        title: const Text('Manage Address'),
        backgroundColor: ColorManager.scaffoldBg,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 22.0, top: 10),
              child: Text(
                'Review and manage your warehouse Address',
                style: TextStyle(color: ColorManager.black),
              ),
            ),
            GestureDetector(
              onTap: () => showAddressFormSheet(context),
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ColorManager.primaryBlue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, color: ColorManager.primaryBlue),
                    Text(
                      ' Add New Address',
                      style: TextStyle(color: ColorManager.primaryBlue),
                    ),
                  ],
                ),
              ),
            ),
            addressState.when(
              data: (state) => state.addresses.isEmpty
                  ? const Expanded(
                      child: Center(child: Text("No addresses found")),
                    )
                  : Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: state.addresses.length,
                        itemBuilder: (context, index) {
                          final addr = state.addresses[index];
                          return _buildAddressCard(
                              addr, state.defaultAddressId);
                        },
                      ),
                    ),
              loading: () => const Expanded(
                child: Center(child: ThreeDotsLoader()),
              ),
              error: (error, _) => Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error: $error"),
                      TextButton(
                        onPressed: () =>
                            ref.invalidate(courierSettingsProvider),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(OrderAddressEntity addr, int? defaultAddressId) {
    final isSelected = defaultAddressId == addr.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? const Color(0xFF1E56A0) : const Color(0xFFE8EEF5),
          width: isSelected ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  addr.name ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () =>
                        showAddressFormSheet(context, address: addr),
                    icon: const Icon(Icons.edit, size: 18),
                  ),
                  IconButton(
                    onPressed: () => _confirmDelete(context, addr),
                    icon: const Icon(Icons.delete, size: 18),
                  ),
                  if (addr.isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Default",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () async {
                        if (addr.id == null) return;
                        final success = await ref
                            .read(courierSettingsProvider.notifier)
                            .setDefaultAddress(addr.id!);

                        if (!mounted) return;
                        if (success) {
                          ref.invalidate(manageAddressProvider);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: ColorManager.lightGreen,
                              content: Text(
                                "Default address changed successfully!",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Failed to set default address"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.lightBlueBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Set Default",
                          style: TextStyle(
                            color: ColorManager.primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "${addr.addressLane1}, ${addr.addressLane2}",
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          if (addr.landmark != null && addr.landmark!.isNotEmpty)
            Text(
              addr.landmark!,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
                height: 1.4,
              ),
            ),
          Text(
            "${addr.city}, ${addr.state}",
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          Text(
            "Pincode: ${addr.pin}",
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, OrderAddressEntity addr) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Address"),
        content: const Text("Are you sure you want to delete this address?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (addr.id != null) {
                ref
                    .read(manageAddressProvider.notifier)
                    .deleteAddress(addr.id!);
              }
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
