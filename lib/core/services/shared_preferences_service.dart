import 'dart:convert';
import 'package:sharkship/features/user/presentation/state/user_role.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      // Log the error but don't crash the app startup
      print('[SharedPreferencesService] Failed to initialize: $e');
    }
  }

  static bool getHasSeenIntro() {
    // If prefs is null (failed init), default to false to be safe
    return _prefs?.getBool('has_seen_intro') ?? false;
  }

  static Future<void> setHasSeenIntro(bool value) async {
    await _prefs?.setBool('has_seen_intro', value);
  }

  static String? getUserRole() {
    return _prefs?.getString('user_role');
  }

  static Future<void> setUserRole(String role) async {
    await _prefs?.setString('user_role', role);
  }

  static Future<void> clearUserRole() async {
    await _prefs?.remove('user_role');
  }

  static SupportRoleUserDetails? getSupportDetails() {
    final str = _prefs?.getString('support_details');
    if (str == null) return null;
    try {
      return SupportRoleUserDetails.fromJson(jsonDecode(str));
    } catch (e) {
      print('[SharedPreferencesService] Error decoding support details: $e');
      return null;
    }
  }

  static Future<void> setSupportDetails(SupportRoleUserDetails details) async {
    await _prefs?.setString('support_details', jsonEncode(details.toJson()));
  }

  static Future<void> clearSupportDetails() async {
    await _prefs?.remove('support_details');
  }
}