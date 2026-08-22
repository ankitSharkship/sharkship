import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/courier_settings_notifier.dart';
import '../../domain/entities/order_address_entity.dart';

/// Pickup-address picker used ONLY by the single-order ship flow
/// (`SingleOrderShipForm`). Unlike [AddressPickerForm] this never mutates the
/// merchant's account-wide default pickup address (no `setDefaultAddress`
/// call) — it just hands the chosen address id to [onNext] for this one
/// order's rate lookup.
class SingleOrderShipAddressForm extends ConsumerStatefulWidget {
  final int? initialAddressId;
  final ValueChanged<int> onNext;
  final VoidCallback? onPrevious;

  const SingleOrderShipAddressForm({
    super.key,
    required this.onNext,
    this.initialAddressId,
    this.onPrevious,
  });

  @override
  ConsumerState<SingleOrderShipAddressForm> createState() =>
      _SingleOrderShipAddressFormState();
}

class _SingleOrderShipAddressFormState
    extends ConsumerState<SingleOrderShipAddressForm> {
  int? selectedAddressId;

  @override
  void initState() {
    super.initState();
    selectedAddressId = widget.initialAddressId;
    if (selectedAddressId == null) {
      // The provider may still be loading at this point (e.g. first time
      // this bottom sheet flow runs and courierSettingsProvider hasn't
      // resolved yet) — a plain ref.read here can miss the data entirely.
      // Fall back to ref.listen in build() to catch it arriving late.
      // Either way, the address list itself always renders as soon as
      // `state` resolves below — this only best-effort preselects a
      // default so the user doesn't have to tap one manually.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref.read(courierSettingsProvider).whenData(_applyDefaultSelection);
      });
    }
  }

  void _applyDefaultSelection(dynamic settings) {
    if (selectedAddressId != null || settings.addresses.isEmpty) return;
    final id = _pickDefaultId(settings.addresses);
    if (id != null) setState(() => selectedAddressId = id);
  }

  void _handleNext() {
    // If the user never tapped a card, ship to the default pickup address
    // rather than leaving Next inert — the user shouldn't get stuck just
    // because they didn't explicitly touch a selection.
    final id = selectedAddressId ?? _defaultAddressId();
    if (id == null) return;
    widget.onNext(id);
  }

  int? _defaultAddressId() {
    final addresses = ref.read(courierSettingsProvider).value?.addresses;
    if (addresses == null) return null;
    return _pickDefaultId(addresses);
  }

  // Deliberately a plain loop, not `addresses.firstWhere(..., orElse: () =>
  // addresses.first)` — `addresses`'s static type is List<OrderAddressEntity>
  // but the underlying list is actually List<OrderAddressModel>, so a
  // `() => OrderAddressEntity` orElse closure fails Dart's runtime generic
  // check the moment orElse actually needs to fire (i.e. no address is
  // flagged default) with "type '() => OrderAddressEntity' is not a subtype
  // of type '(() => OrderAddressModel)?' of 'orElse'".
  int? _pickDefaultId(List<OrderAddressEntity> addresses) {
    if (addresses.isEmpty) return null;
    for (final addr in addresses) {
      if (addr.isDefault) return addr.id;
    }
    return addresses.first.id;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(courierSettingsProvider);

    ref.listen(courierSettingsProvider, (previous, next) {
      next.whenData(_applyDefaultSelection);
    });

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
              Padding(
                padding: EdgeInsets.fromLTRB(
                  15,
                  8,
                  15,
                  8 + MediaQuery.of(context).padding.bottom,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (widget.onPrevious != null) {
                            widget.onPrevious!();
                          } else {
                            Navigator.pop(context);
                          }
                        },
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
                          "Previous",
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
                        onTap: addresses.isEmpty ? null : _handleNext,
                        text: "Next",
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
