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
}