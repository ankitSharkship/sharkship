import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/state/orders_tab_provider.dart';
import 'package:sharkship/features/orders/presentation/state/selected_orders_notifier.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../state/courier_settings_notifier.dart';
import '../../domain/entities/courier_partner_entity.dart';
import '../../domain/entities/courier_priority_entity.dart';
import 'package:sharkship/features/orders/presentation/state/orders_notifier.dart';

class CourierPriorityForm extends ConsumerStatefulWidget {
  final bool onlyCourier;
  final int? orderId;
  const CourierPriorityForm({super.key, this.onlyCourier = true, this.orderId});

  @override
  ConsumerState<CourierPriorityForm> createState() =>
      _CourierPriorityFormState();
}

class _CourierPriorityFormState extends ConsumerState<CourierPriorityForm> {
  List<CourierPartnerEntity> selectedPartners = [];
  bool isSaving = false;
  bool _initialized = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    print(widget.orderId);
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = ref.read(courierSettingsProvider);
      state.whenData((settings) {
        if (!_initialized) {
          _initializeSelected(settings);
        }
      });
    });
  }

  void _initializeSelected(dynamic settings) {
    if (settings.priority == null) {
      setState(() => _initialized = true);
      return;
    }
    final priority = settings.priority as CourierPriorityEntity;
    final partners = settings.partners as List<CourierPartnerEntity>;

    final List<Map<String, dynamic>> savedConfigs = [
      {
        'id': priority.priority1,
        'type': priority.priority1Type,
        'weight': priority.priority1BaseWeight,
        'service': priority.priority1ServiceType,
      },
      {
        'id': priority.priority2,
        'type': priority.priority2Type,
        'weight': priority.priority2BaseWeight,
        'service': priority.priority2ServiceType,
      },
      {
        'id': priority.priority3,
        'type': priority.priority3Type,
        'weight': priority.priority3BaseWeight,
        'service': priority.priority3ServiceType,
      },
      {
        'id': priority.priority4,
        'type': priority.priority4Type,
        'weight': priority.priority4BaseWeight,
        'service': priority.priority4ServiceType,
      },
      {
        'id': priority.priority5,
        'type': priority.priority5Type,
        'weight': priority.priority5BaseWeight,
        'service': priority.priority5ServiceType,
      },
    ];

    List<CourierPartnerEntity> initial = [];
    for (var cfg in savedConfigs) {
      if (cfg['id'] != null) {
        try {
          // Match based on Id + Type + Weight + Service
          final partner = partners.firstWhere(
            (p) =>
                p.carrierId == cfg['id'] &&
                p.courierType == cfg['type'] &&
                double.tryParse(p.baseWeight) ==
                    double.tryParse(cfg['weight'] ?? "") &&
                p.serviceType == cfg['service'],
          );
          initial.add(partner);
        } catch (_) {
          // Fallback if full match fails (maybe API changed)
          try {
            final partner = partners.firstWhere(
              (p) => p.carrierId == cfg['id'],
            );
            initial.add(partner);
          } catch (_) {}
        }
      }
    }
    setState(() {
      selectedPartners = initial;
      _initialized = true;
    });
  }

  bool _isPartnerSelected(CourierPartnerEntity p) {
    return selectedPartners.any(
      (sp) =>
          sp.carrierId == p.carrierId &&
          sp.courierType == p.courierType &&
          sp.baseWeight == p.baseWeight &&
          p.serviceType == sp.serviceType,
    );
  }

  void _showCourierPicker(List<CourierPartnerEntity> allPartners) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setPickerState) {
            final filtered = allPartners.where((p) {
              final query = _searchController.text.toLowerCase();
              return p.carrier.toLowerCase().contains(query) ||
                  p.courierType.toLowerCase().contains(query);
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
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Done",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
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
                        final p = filtered[index];
                        final isSelected = _isPartnerSelected(p);

                        return CheckboxListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          title: Text(
                            "${p.carrier} (${p.courierType})",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          subtitle: Text(
                            "${p.baseWeight}kg | ${p.serviceType}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          value: isSelected,
                          activeColor: const Color(0xFF1E56A0),
                          onChanged: (val) {
                            if (val == true) {
                              if (selectedPartners.length >= 5) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Max 5 allowed"),
                                  ),
                                );
                                return;
                              }
                              setState(() => selectedPartners.add(p));
                            } else {
                              setState(
                                () => selectedPartners.removeWhere(
                                  (sp) =>
                                      sp.carrierId == p.carrierId &&
                                      sp.courierType == p.courierType &&
                                      sp.baseWeight == p.baseWeight &&
                                      sp.serviceType == p.serviceType,
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

  Future<void> _handleSave() async {
    setState(() => isSaving = true);
    Map<String, dynamic> payload = {};

    for (int i = 0; i < 5; i++) {
      final num = i + 1;
      if (i < selectedPartners.length) {
        final p = selectedPartners[i];
        payload["priority_$num"] = p.carrierId.toString();
        payload["priority_${num}_type"] = p.courierType;
        payload["priority_${num}_base_weight"] =
            double.tryParse(p.baseWeight) ?? 0.5;
        payload["priority_${num}_service_type"] = p.serviceType;
      } else {
        payload["priority_$num"] = null;
        payload["priority_${num}_type"] = null;
        payload["priority_${num}_base_weight"] = null;
        payload["priority_${num}_service_type"] = null;
      }
    }

    final success = await ref
        .read(courierSettingsProvider.notifier)
        .updatePriority(payload);

    if (mounted) {
      setState(() => isSaving = false);
      if (success) {
        Navigator.pop(context);
        if (widget.onlyCourier) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Priority saved successfully")),
          );
        } else {
          final selectedTab = ref.read(ordersTabProvider);
          final shipOrders = await ref
              .read(selectedOrdersProvider(selectedTab).notifier)
              .shipSelected(widget.orderId);
          print(shipOrders);
          if (shipOrders) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Request Received")));
            ref.invalidate(ordersProvider(selectedTab));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to ship orders")),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to save priority")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(courierSettingsProvider);

    ref.listen(courierSettingsProvider, (previous, next) {
      if (next is AsyncData && !_initialized) {
        _initializeSelected(next.value!);
      }
    });

    return settingsAsync.when(
      data: (settings) {
        if (!_initialized) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: ThreeDotsLoader(),
            ),
          );
        }

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
                child: Row(
                  children: [
                     Expanded(
                      child: Center(
                        child: Text(
                          "Select Courier Priority",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
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

              // Scrollable List
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  children: [
                    // Priority Cards
                    ...selectedPartners.asMap().entries.map((entry) {
                      final index = entry.key;
                      final p = entry.value;
                      return _buildPriorityCard(index + 1, p);
                    }).toList(),

                    const SizedBox(height: 16),

                    // More Courier Button
                    InkWell(
                      onTap: () => _showCourierPicker(settings.partners),
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
                          children:  [
                            Icon(
                              Icons.tune,
                              size: 20,
                              color: Color(0xFF4A4A4A),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "More Courier Option",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

              // Save Button
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: GradientButton(
                    onTap: isSaving ? null : _handleSave,
                    text: "Save",
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: const Color(0xFF1E56A0),
                    //   foregroundColor: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   elevation: 0,
                    // ),
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
        );
      },
      loading: () => const Center(
        child: Padding(padding: EdgeInsets.all(50), child: ThreeDotsLoader()),
      ),
      error: (e, _) => Center(child: Text("Error: $e")),
    );
  }

  Widget _buildPriorityCard(int index, CourierPartnerEntity p) {
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
                  "$index) ${p.carrier} ${p.baseWeight}Kg (${p.courierType})",
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
                    p.serviceType,
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
                    selectedPartners.removeAt(index - 1);
                  });
                },
                child: Icon(Icons.close, size: 20, color: Colors.grey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
