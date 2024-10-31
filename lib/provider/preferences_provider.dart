import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/utils/preferences_helper.dart';
import 'package:flutter/material.dart';
import '../common/styles.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyUpdatesPreferences();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyUpdatesActive = false;
  bool get isDailyUpdatesActive => _isDailyUpdatesActive;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyUpdatesPreferences() async {
    _isDailyUpdatesActive = await preferencesHelper.isDailyUpdatesActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyUpdates(bool value) {
    preferencesHelper.setDailyUpdates(value);
    _getDailyUpdatesPreferences();
  }
}