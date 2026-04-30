import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/businessTools/domain/entities/shipping_label_config_entity.dart';
import 'business_tools_providers.dart';

part 'shipping_label_notifier.g.dart';

class ShippingLabelState {
  final bool rtoVisibility;
  final bool sharkshipVisibility;
  final bool logoVisibility;
  final bool gstVisibility;
  final bool clientVisibility;
  final bool skuVisibility;
  final bool alterName;
  final bool phoneVisibility;
  final bool rtoPhoneVisibility;
  final bool tableVisibility;
  final bool isAmountVisible;
  final String newName;
  final String labelSize;
  final bool isSubmitting;

  const ShippingLabelState({
    required this.rtoVisibility,
    required this.sharkshipVisibility,
    required this.logoVisibility,
    required this.gstVisibility,
    required this.clientVisibility,
    required this.skuVisibility,
    required this.alterName,
    required this.phoneVisibility,
    required this.rtoPhoneVisibility,
    required this.tableVisibility,
    required this.isAmountVisible,
    required this.newName,
    required this.labelSize,
    this.isSubmitting = false,
  });

  factory ShippingLabelState.fromEntity(ShippingLabelConfigEntity entity) {
    return ShippingLabelState(
      rtoVisibility: entity.rtoVisibility,
      sharkshipVisibility: entity.sharkshipVisibility,
      logoVisibility: entity.logoVisibility,
      gstVisibility: entity.gstVisibility,
      clientVisibility: entity.clientVisibility,
      skuVisibility: entity.skuVisibility,
      alterName: entity.alterName,
      phoneVisibility: entity.phoneVisibility,
      rtoPhoneVisibility: entity.rtoPhoneVisibility,
      tableVisibility: entity.tableVisibility,
      isAmountVisible: entity.isAmountVisible,
      newName: entity.newName,
      labelSize: entity.labelSize,
    );
  }

  ShippingLabelState copyWith({
    bool? rtoVisibility,
    bool? sharkshipVisibility,
    bool? logoVisibility,
    bool? gstVisibility,
    bool? clientVisibility,
    bool? skuVisibility,
    bool? alterName,
    bool? phoneVisibility,
    bool? rtoPhoneVisibility,
    bool? tableVisibility,
    bool? isAmountVisible,
    String? newName,
    String? labelSize,
    bool? isSubmitting,
  }) {
    return ShippingLabelState(
      rtoVisibility: rtoVisibility ?? this.rtoVisibility,
      sharkshipVisibility: sharkshipVisibility ?? this.sharkshipVisibility,
      logoVisibility: logoVisibility ?? this.logoVisibility,
      gstVisibility: gstVisibility ?? this.gstVisibility,
      clientVisibility: clientVisibility ?? this.clientVisibility,
      skuVisibility: skuVisibility ?? this.skuVisibility,
      alterName: alterName ?? this.alterName,
      phoneVisibility: phoneVisibility ?? this.phoneVisibility,
      rtoPhoneVisibility: rtoPhoneVisibility ?? this.rtoPhoneVisibility,
      tableVisibility: tableVisibility ?? this.tableVisibility,
      isAmountVisible: isAmountVisible ?? this.isAmountVisible,
      newName: newName ?? this.newName,
      labelSize: labelSize ?? this.labelSize,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  ShippingLabelConfigEntity toEntity() {
    return ShippingLabelConfigEntity(
      id: 1,
      rtoVisibility: rtoVisibility,
      sharkshipVisibility: sharkshipVisibility,
      logoVisibility: logoVisibility,
      gstVisibility: gstVisibility,
      clientVisibility: clientVisibility,
      skuVisibility: skuVisibility,
      alterName: alterName,
      phoneVisibility: phoneVisibility,
      rtoPhoneVisibility: rtoPhoneVisibility,
      tableVisibility: tableVisibility,
      isAmountVisible: isAmountVisible,
      newName: newName,
      labelSize: labelSize,
    );
  }
}

@riverpod
class ShippingLabelNotifier extends _$ShippingLabelNotifier {
  @override
  FutureOr<ShippingLabelState> build() async {
    final result = await ref
        .read(getShippingLabelConfigUseCaseProvider)
        .call();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (entity) => ShippingLabelState.fromEntity(entity),
    );
  }

  void toggleRtoVisibility(bool value) {
    _updateState((s) => s.copyWith(rtoVisibility: value));
  }

  void toggleSharkshipVisibility(bool value) {
    _updateState((s) => s.copyWith(sharkshipVisibility: value));
  }

  void toggleLogoVisibility(bool value) {
    _updateState((s) => s.copyWith(logoVisibility: value));
  }

  void toggleGstVisibility(bool value) {
    _updateState((s) => s.copyWith(gstVisibility: value));
  }

  void toggleClientVisibility(bool value) {
    _updateState((s) => s.copyWith(clientVisibility: value));
  }

  void toggleSkuVisibility(bool value) {
    _updateState((s) => s.copyWith(skuVisibility: value));
  }

  void toggleAlterName(bool value) {
    _updateState((s) => s.copyWith(alterName: value));
  }

  void togglePhoneVisibility(bool value) {
    _updateState((s) => s.copyWith(phoneVisibility: value));
  }

  void toggleRtoPhoneVisibility(bool value) {
    _updateState((s) => s.copyWith(rtoPhoneVisibility: value));
  }

  void toggleTableVisibility(bool value) {
    _updateState((s) => s.copyWith(tableVisibility: value));
  }

  void toggleAmountVisibility(bool value) {
    _updateState((s) => s.copyWith(isAmountVisible: value));
  }

  void updateNewName(String value) {
    _updateState((s) => s.copyWith(newName: value));
  }

  void updateLabelSize(String value) {
    _updateState((s) => s.copyWith(labelSize: value));
  }

  Future<void> submitConfig(BuildContext context) async {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(isSubmitting: true));

    final result = await ref
        .read(updateShippingLabelConfigUseCaseProvider)
        .call(currentState.toEntity());

    result.fold(
      (failure) {
        state = AsyncValue.data(currentState.copyWith(isSubmitting: false));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      (_) {
        state = AsyncValue.data(currentState.copyWith(isSubmitting: false));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Shipping label settings saved successfully.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
    );
  }

  void _updateState(ShippingLabelState Function(ShippingLabelState) updater) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(updater(current));
  }
}
