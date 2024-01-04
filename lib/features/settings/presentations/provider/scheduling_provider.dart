import 'package:dicoding_final/features/settings/domain/usecases/turn_notification.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier {
  SchedulingProvider({required TurnNotification turnNotification})
      : _turnNotification = turnNotification;
  final TurnNotification _turnNotification;

  bool _isScheduled = false;
  String _errorMessage = '';
  bool get isScheduled => _isScheduled;
  String get errorMessage => _errorMessage;

  Future<void> scheduledRestaurant({bool value = false}) async {
    _isScheduled = value;
    final result = await _turnNotification(value);
    result.fold(
      (failure) => _errorMessage = failure.errorMessage,
      (r) => null,
    );
    notifyListeners();
  }
}
