import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/orders/presentation/widgets/courier_priority_form.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/courier_settings_notifier.dart';
import '../../domain/entities/order_address_entity.dart';

class AddressPickerForm extends ConsumerStatefulWidget {
  final bool onlyAddress;
  final VoidCallback? onNext;
  const AddressPickerForm({super.key, this.onlyAddress = true, this.onNext});

  @override
  ConsumerState<AddressPickerForm> createState() => _AddressPickerFormState();
}

class _AddressPickerFormState extends ConsumerState<AddressPickerForm> {
  int? selectedAddressId;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _initSelection();
  }

  void _initSelection() {
    final state = ref.read(courierSettingsProvider);
    state.whenData((settings) {
      final defaultAddr = settings.addresses.firstWhere(
        (a) => a.isDefault,
        orElse: () => settings.addresses.first,
      );
      setState(() {
        selectedAddressId = defaultAddr.id;
      });
    });
  }

  Future<void> _handleSave() async {
    if (selectedAddressId == null) return;
    setState(() => isSaving = true);

    final success = await ref
        .read(courierSettingsProvider.notifier)
        .setDefaultAddress(selectedAddressId!);

    if (mounted) {
      setState(() => isSaving = false);
      if (success) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to set default address")),
        );
      }
    }
  }

  Future<void> _handleNext() async {
    if (selectedAddressId != null) {
      setState(() {
        isSaving = true;
      });
      final success = await ref
          .read(courierSettingsProvider.notifier)
          .setDefaultAddress(selectedAddressId!);
      if (mounted) {
        setState(() {
          isSaving = false;
        });
        if (!success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to set default address")),
          );
        } else {
          try {
            if (widget.onNext != null) {
              widget.onNext!();
            } else {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                    const CourierPriorityForm(onlyCourier: false),
              );
            }
          } catch (e) {
            print(e);
          }
        }
      }
    } else {
      try {
        if (widget.onNext != null) {
          widget.onNext!();
        } else {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) => const CourierPriorityForm(onlyCourier: false),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(courierSettingsProvider);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: state.when(
        data: (settings) {
          final addresses = settings.addresses;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Select Address",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Scrollable List
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final addr = addresses[index];
                    return _buildAddressCard(addr);
                  },
                ),
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          backgroundColor: const Color(
                            0xFF0EA5E9,
                          ).withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        child: Text(
                          "Cancel",
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: const Color(0xFF0EA5E9),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GradientButton(
                        onTap: widget.onlyAddress
                            ? (isSaving ? null : _handleSave)
                            : _handleNext,
                        // style: ElevatedButton.styleFrom(
                        //   backgroundColor: const Color(0xFF1E56A0).withOpacity(
                        //     0.4,
                        //   ), // Based on image's semi-transparent blue look for Save if inactive
                        //   foregroundColor: Colors.white,
                        //   disabledBackgroundColor: const Color(
                        //     0xFF1E56A0,
                        //   ).withOpacity(0.4),
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 32,
                        //     vertical: 12,
                        //   ),
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   elevation: 0,
                        // ),
                        text: widget.onlyAddress ? "Save" : "Next",
                        child: isSaving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Padding(padding: EdgeInsets.all(50), child: ThreeDotsLoader()),
        ),
        error: (e, _) => Center(
          child: ErrorCard(
            onRetry: () => ref.invalidate(courierSettingsProvider),
            errMssg: "Something went wrong",
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(OrderAddressEntity addr) {
    final isSelected = selectedAddressId == addr.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddressId = addr.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1E56A0)
                : const Color(0xFFE8EEF5),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
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
                    child: Text(
                      "Default",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "${addr.addressLane1}, ${addr.addressLane2}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            if (addr.landmark != null && addr.landmark!.isNotEmpty)
              Text(
                addr.landmark!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
            Text(
              "${addr.city}, ${addr.state}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            Text(
              "Pincode: ${addr.pin}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF64748B),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
