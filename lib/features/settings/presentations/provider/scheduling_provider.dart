import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_final/core/services/background_service.dart';
import 'package:dicoding_final/core/services/date_time_helper.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews({bool value = false}) {
    _isScheduled = value;
    if (_isScheduled) {
      log('Scheduling News Activated');
      notifyListeners();
      return AndroidAlarmManager.periodic(
        const Duration(seconds: 5),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      log('Scheduling News Canceled');
      notifyListeners();
      return AndroidAlarmManager.cancel(1);
    }
  }
}
