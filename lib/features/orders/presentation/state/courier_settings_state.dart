import '../../domain/entities/courier_partner_entity.dart';
import '../../domain/entities/courier_priority_entity.dart';
import '../../domain/entities/order_address_entity.dart';

class CourierSettingsState {
  final CourierPriorityEntity? priority;
  final List<CourierPartnerEntity> partners;
  final List<OrderAddressEntity> addresses;
  final bool isLoading;
  final String? error;

  CourierSettingsState({
    this.priority,
    this.partners = const [],
    this.addresses = const [],
    this.isLoading = false,
    this.error,
  });

  CourierSettingsState copyWith({
    CourierPriorityEntity? priority,
    List<CourierPartnerEntity>? partners,
    List<OrderAddressEntity>? addresses,
    bool? isLoading,
    String? error,
  }) {
    return CourierSettingsState(
      priority: priority ?? this.priority,
      partners: partners ?? this.partners,
      addresses: addresses ?? this.addresses,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
