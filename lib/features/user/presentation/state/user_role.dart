import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final userRoleProvider = StateProvider<UserRole?>((ref) => null);

final supportRoleUserDetailsProvider = StateProvider<SupportRoleUserDetails?>(
  (ref) => null,
);

final allowedFeaturesProvider = Provider<Set<AppFeature>>((ref) {
  final role = ref.watch(userRoleProvider);

  if (role == null) {
    return {};
  }

  return RolePermissions.getAllowedFeatures(role);
});

class SupportRoleUserDetails {
  final String name;
  final String email;
  final String role;
  final String userId;

  SupportRoleUserDetails({
    required this.name,
    required this.email,
    required this.role,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'role': role,
        'userId': userId,
      };

  factory SupportRoleUserDetails.fromJson(Map<String, dynamic> json) =>
      SupportRoleUserDetails(
        name: json['name'] as String,
        email: json['email'] as String,
        role: json['role'] as String,
        userId: json['userId'] as String,
      );
}

enum UserRole {
  admin,
  operationsUser,
  supportUser;

  static UserRole fromString(String value) {
    switch (value) {
      case 'OWNER':
        return UserRole.admin;

      case 'OPERATION_USER':
        return UserRole.operationsUser;

      case 'SUPPORT_USER':
        return UserRole.supportUser;

      default:
        return UserRole.supportUser;
    }
  }

  String toApiString() {
    switch (this) {
      case UserRole.admin:
        return 'OWNER';

      case UserRole.operationsUser:
        return 'OPERATION_USER';

      case UserRole.supportUser:
        return 'SUPPORT_USER';
    }
  }
}

enum AppFeature {
  dashboards,
  orders,
  exceptions,
  tickets,
  weightMismatches,
  reports,
  informationCenter,
  walletTransactions,
  remittances,
  services,
  invoiceTemplates,
  pickupLocations,
  sellers,
  companySettings,
  userManagement,
}

class RolePermissions {
  static const Map<UserRole, Set<AppFeature>> permissions = {
    UserRole.admin: {
      AppFeature.dashboards,
      AppFeature.orders,
      AppFeature.exceptions,
      AppFeature.tickets,
      AppFeature.reports,
      AppFeature.informationCenter,
      AppFeature.remittances,
      AppFeature.services,
      AppFeature.invoiceTemplates,
      AppFeature.pickupLocations,
      AppFeature.sellers,
    },

    UserRole.operationsUser: {
      AppFeature.dashboards,
      AppFeature.orders,
      AppFeature.exceptions,
      AppFeature.reports,
      AppFeature.informationCenter,
      AppFeature.pickupLocations,
      AppFeature.sellers,
    },

    UserRole.supportUser: {AppFeature.exceptions, AppFeature.tickets},
  };

  static bool hasAccess(UserRole role, AppFeature feature) {
    return permissions[role]?.contains(feature) ?? false;
  }

  static Set<AppFeature> getAllowedFeatures(UserRole role) {
    return permissions[role] ?? {};
  }
}
