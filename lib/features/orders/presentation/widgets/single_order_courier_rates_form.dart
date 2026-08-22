import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/selected_orders_notifier.dart';
import 'package:sharkship/features/orders/presentation/state/single_order_courier_rates_notifier.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/courier_settings_notifier.dart';
import '../../domain/entities/courier_rate_entity.dart';
import '../../domain/entities/courier_priority_entity.dart';

/// Courier selection step for the single-order ship flow ONLY. Same
/// multi-select "priority" UI/UX as the shared `CourierPriorityForm`, but
/// the list comes from this order's live rates (`GET v1/calculator/rates`)
/// with the price shown under each carrier, instead of the merchant's
/// static courier-partner catalogue.
class SingleOrderCourierRatesForm extends ConsumerStatefulWidget {
  final int orderId;
  final int pickupAddressId;
  final VoidCallback? onPrevious;

  const SingleOrderCourierRatesForm({
    super.key,
    required this.orderId,
    required this.pickupAddressId,
    this.onPrevious,
  });

  @override
  ConsumerState<SingleOrderCourierRatesForm> createState() =>
      _SingleOrderCourierRatesFormState();
}

class _SingleOrderCourierRatesFormState
    extends ConsumerState<SingleOrderCourierRatesForm> {
  List<CourierRateEntity> selectedRates = [];
  bool isSaving = false;
  bool _initialized = false;
  final TextEditingController _searchController = TextEditingController();

  (int, int) get _key => (widget.orderId, widget.pickupAddressId);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _tryInitializeDefault();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Best-effort preselect of the merchant's saved "priority 1" courier,
  /// matched against this order's live rates — mirrors CourierPriorityForm
  /// but only for the single default slot (not all 5 saved priorities).
  /// Never blocks rendering: the rate list itself always renders as soon as
  /// `singleOrderCourierRatesProvider` resolves, regardless of whether this
  /// has finished.
  void _tryInitializeDefault() {
    if (_initialized) return;

    final ratesValue = ref.read(singleOrderCourierRatesProvider(_key));
    final rates = ratesValue.value?.rates;
    if (rates == null) return; // rates not ready yet; retry via ref.listen

    final settingsValue = ref.read(courierSettingsProvider);
    if (settingsValue.isLoading) return; // settings not ready yet; retry

    final priority = settingsValue.value?.priority;
    final match = priority == null ? null : _matchPriority1(priority, rates);

    setState(() {
      if (match != null) selectedRates = [match];
      _initialized = true;
    });
  }

  CourierRateEntity? _matchPriority1(
    CourierPriorityEntity priority,
    List<CourierRateEntity> rates,
  ) {
    if (priority.priority1 == null) return null;
    final targetWeight = double.tryParse(priority.priority1BaseWeight ?? '');
    for (final r in rates) {
      if (r.carrierId == priority.priority1 &&
          r.courierType == priority.priority1Type &&
          r.serviceType == priority.priority1ServiceType &&
          (targetWeight == null || r.baseWeight.toDouble() == targetWeight)) {
        return r;
      }
    }
    for (final r in rates) {
      if (r.carrierId == priority.priority1) return r;
    }
    return null;
  }

  // The API reuses the same `id` for a carrier's NDD/SDD/PAN_INDIA rows that
  // only differ by service type (e.g. Blitz's NDD and SDD rate both come
  // back with id `f5348506-...`), so `id` alone can't tell two rows apart.
  // Compare the same (carrierId, courierType, baseWeight, serviceType)
  // tuple CourierPartnerEntity has always used instead.
  bool _sameRate(CourierRateEntity a, CourierRateEntity b) {
    return a.carrierId == b.carrierId &&
        a.courierType == b.courierType &&
        a.baseWeight == b.baseWeight &&
        a.serviceType == b.serviceType;
  }

  bool _isRateSelected(CourierRateEntity r) {
    return selectedRates.any((sr) => _sameRate(sr, r));
  }

  void _showCourierPicker(List<CourierRateEntity> allRates) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setPickerState) {
            final filtered = allRates.where((r) {
              final query = _searchController.text.toLowerCase();
              return r.carrier.toLowerCase().contains(query) ||
                  r.courierType.toLowerCase().contains(query);
            }).toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Select Couriers",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Done",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search courier partners...",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF1E56A0),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (_) => setPickerState(() {}),
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final r = filtered[index];
                        final isSelected = _isRateSelected(r);

                        return CheckboxListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          title: Text(
                            "${r.carrier} (${r.courierType})",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "${r.baseWeight}kg | ${r.serviceType} | ₹${r.rate}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          value: isSelected,
                          activeColor: const Color(0xFF1E56A0),
                          onChanged: (val) {
                            if (val == true) {
                              if (selectedRates.length >= 5) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Max 5 allowed"),
                                  ),
                                );
                                return;
                              }
                              setState(() => selectedRates.add(r));
                            } else {
                              setState(
                                () => selectedRates.removeWhere(
                                  (sr) => _sameRate(sr, r),
                                ),
                              );
                            }
                            setPickerState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleShip() async {
    if (selectedRates.isEmpty) return;
    setState(() => isSaving = true);

    final Map<String, dynamic> payload = {};
    for (int i = 0; i < 5; i++) {
      final num = i + 1;
      if (i < selectedRates.length) {
        final r = selectedRates[i];
        payload["priority_$num"] = r.carrierId.toString();
        payload["priority_${num}_type"] = r.courierType;
        payload["priority_${num}_base_weight"] = r.baseWeight;
        payload["priority_${num}_service_type"] = r.serviceType;
      } else {
        payload["priority_$num"] = null;
        payload["priority_${num}_type"] = null;
        payload["priority_${num}_base_weight"] = null;
        payload["priority_${num}_service_type"] = null;
      }
    }

    final prioritySaved = await ref
        .read(courierSettingsProvider.notifier)
        .updatePriority(payload);

    if (!mounted) return;

    if (!prioritySaved) {
      setState(() => isSaving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to save priority")));
      return;
    }

    final selectedTab = ref.read(ordersTabProvider);
    try {
      final shipped = await ref
          .read(selectedOrdersProvider(selectedTab).notifier)
          .shipSelected(widget.orderId);
      if (!mounted) return;
      setState(() => isSaving = false);
      if (shipped) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Request Received")));
        ref.invalidate(ordersProvider(selectedTab));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Failed to ship order")));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isSaving = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to ship order")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final key = _key;
    final ratesAsync = ref.watch(singleOrderCourierRatesProvider(key));

    ref.listen(singleOrderCourierRatesProvider(key), (previous, next) {
      next.whenData((_) => _tryInitializeDefault());
    });
    ref.listen(courierSettingsProvider, (previous, next) {
      next.whenData((_) => _tryInitializeDefault());
    });

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: ratesAsync.when(
        data: (data) {
          final allRates = data.rates;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Select Courier Priority",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF1A1A1A),
                              ),
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  children: [
                    if (allRates.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            'No shipping rates available for this order.',
                          ),
                        ),
                      ),
                    ...selectedRates.asMap().entries.map((entry) {
                      final index = entry.key;
                      final r = entry.value;
                      return _buildPriorityCard(index + 1, r);
                    }),
                    const SizedBox(height: 16),
                    if (allRates.isNotEmpty)
                      InkWell(
                        onTap: () => _showCourierPicker(allRates),
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFE8EEF5),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.tune,
                                size: 20,
                                color: Color(0xFF4A4A4A),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "More Courier Option",
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF4A4A4A),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
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
                        onPressed: isSaving
                            ? null
                            : () {
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
                      child: SizedBox(
                        height: 56,
                        child: GradientButton(
                          onTap: (isSaving || selectedRates.isEmpty)
                              ? null
                              : _handleShip,
                          text: "Ship Now",
                          child: isSaving
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : null,
                        ),
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
            onRetry: () => ref.invalidate(singleOrderCourierRatesProvider(key)),
            errMssg: "Something went wrong",
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityCard(int index, CourierRateEntity r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EEF5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
                  "$index) ${r.carrier} ${r.baseWeight}Kg (${r.courierType})",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF1E56A0), width: 1),
                ),
                child: Text(
                  r.serviceType,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E56A0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRates.removeAt(index - 1);
                  });
                },
                child: Icon(Icons.close, size: 20, color: Colors.grey.shade400),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "₹${r.rate}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E88C8),
            ),
          ),
        ],
      ),
    );
  }
}
