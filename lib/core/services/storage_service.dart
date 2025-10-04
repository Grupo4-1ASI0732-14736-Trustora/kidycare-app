import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String keyOnboarding = "hasSeenOnboarding";

  /// Guarda si el usuario ya vio el onboarding
  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyOnboarding, true);
  }

  /// Revisa si el usuario ya vio el onboarding
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyOnboarding) ?? false;
  }
}
