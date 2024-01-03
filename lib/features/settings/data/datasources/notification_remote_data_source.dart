import 'dart:convert';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationRemoteDataSource {
  const NotificationRemoteDataSource();

  /// Displays a notification to notify the user.
  ///
  /// This function is responsible for triggering the local display of a
  /// notification without sending any network requests.
  ///
  /// Throws a [CacheException] if there is an issue while processing the
  /// notification.
  Future<void> showNotification(List<RestaurantModel> restaurant);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  NotificationRemoteDataSourceImpl({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  Future<void> showNotification(List<RestaurantModel> restaurant) async {
    const channelId = '1';
    const channelName = 'channel_01';
    const channelDescription = 'restaurant channel';

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    const titleNotification = '<b>Daily Restaurant Near You!</b>';
    final titleNews = restaurant[0].name;

    await _flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: jsonEncode(restaurant.map((e) => e.toJson())),
    );
  }
}
