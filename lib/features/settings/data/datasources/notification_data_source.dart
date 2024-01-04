import 'dart:developer';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    required FlutterLocalNotificationsPlugin notificationsPlugin,
  }) : _notificationsPlugin = notificationsPlugin;
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  @override
  Future<void> showNotification({required bool isScheduled}) async {
    if (isScheduled) {
      log('Scheduling News Activated');
      await AndroidAlarmManager.periodic(
        const Duration(seconds: 5),
        1,
        callback,
      );
    } else {
      log('Scheduling News Canceled');
      await AndroidAlarmManager.cancel(1);
    }
  }

  Future<void> callback() async {
    const titleNotification = '<b>Daily Restaurant Near You!</b>';
    await _notificationsPlugin.show(
      0,
      titleNotification,
      'titleNews',
      notificationDetails(),
      payload: 'rqdv5juczeskfw1e867',
    );
  }

  NotificationDetails notificationDetails() {
    const channelId = '1';
    const channelName = 'channel_01';
    const channelDescription = 'restaurant channel';

    return const NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        channelDescription: channelDescription,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}


    // final titleNews = restaurant[0].name;

    // final restaurantList = restaurant.map((e) => e.toJson()).toList();
