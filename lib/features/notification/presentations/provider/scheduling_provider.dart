import 'package:dicoding_final/core/preferences/preferences.dart';
import 'package:dicoding_final/features/notification/domain/usecases/turn_notification.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier {
  SchedulingProvider({
    required TurnNotification turnNotification,
    required Preferences preferences,
  })  : _turnNotification = turnNotification,
        _preferences = preferences;

  final TurnNotification _turnNotification;
  final Preferences _preferences;

  bool _isScheduled = false;
  String _errorMessage = '';
  bool get isScheduled => _isScheduled;
  String get errorMessage => _errorMessage;

  Future<void> scheduledRestaurant({bool value = false}) async {
    _preferences.setDailyNews(value: value);
    isScheduledOn();
    final result = await _turnNotification(value);
    result.fold(
      (failure) => _errorMessage = failure.errorMessage,
      (r) => null,
    );
    notifyListeners();
  }

  void isScheduledOn() {
    _isScheduled = _preferences.isDailyRestaurantctive;
  }
}
