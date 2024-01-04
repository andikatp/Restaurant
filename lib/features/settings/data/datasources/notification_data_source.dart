import 'dart:convert';
import 'dart:developer';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/services/notification_service.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/remote/explore_restaurants_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotificationDataSource {
  const NotificationDataSource();

  /// Displays a notification to notify the user.
  ///
  /// This function is responsible for triggering the local display of a
  /// notification without sending any network requests.
  ///
  /// Throws a [CacheException] if there is an issue while processing the
  /// notification.
  Future<void> showNotification({required bool isScheduled});
}

class NotificationRemoteDataSourceImpl implements NotificationDataSource {
  NotificationRemoteDataSourceImpl({
    required ExploreRestaurantsRemoteDataSource explore,
    required SharedPreferences sharedPreferences,
  })  : _explore = explore,
        _sharedPreferences = sharedPreferences;

  final ExploreRestaurantsRemoteDataSource _explore;
  final SharedPreferences _sharedPreferences;

  @override
  Future<void> showNotification({required bool isScheduled}) async {
    if (isScheduled) {
      log('Scheduling News Activated');
      final restaurants = await _explore.getRestaurants();
      final restaurant = restaurants[0];
      await _sharedPreferences.setString(
        'currentRestaurant',
        jsonEncode(restaurant.toJson()),
      );
      final result = await AndroidAlarmManager.periodic(
        const Duration(seconds: 5),
        1,
        NotificationService.callback,
      );
      log(result.toString());
    } else {
      log('Scheduling News Canceled');
      await AndroidAlarmManager.cancel(1);
    }
  }
}
