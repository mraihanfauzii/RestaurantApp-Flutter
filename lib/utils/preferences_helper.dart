import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final SharedPreferences sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const darkTheme = 'DARK_THEME';
  static const dailyUpdates = 'DAILY_UPDATES';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isDailyUpdatesActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyUpdates) ?? false;
  }

  void setDailyUpdates(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyUpdates, value);
  }
}