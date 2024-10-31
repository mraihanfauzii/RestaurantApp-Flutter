import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/utils/preferences_helper.dart';
import 'package:flutter/material.dart';
import '../utils/background_service.dart';
import '../utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  final PreferencesHelper preferencesHelper;

  SchedulingProvider({ required this.preferencesHelper }) {
    _getScheduledPreferences();
  }

  bool get isScheduled => _isScheduled;

  void _getScheduledPreferences() async {
    _isScheduled =await preferencesHelper.isDailyUpdatesActive;
    notifyListeners();
  }

  Future<bool> scheduledUpdates(bool value) async {
    _isScheduled = value;
    preferencesHelper.setDailyUpdates(value);
    if (_isScheduled) {
      print('Scheduling Reminder Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Reminder Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}