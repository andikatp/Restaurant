import 'dart:convert';
import 'dart:developer';
import 'package:dicoding_final/core/navigation/navigation.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  NotificationHelper._internal() {
    _instance = this;
  }
  static NotificationHelper? _instance;

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    const initializationSettingsAndroid = AndroidInitializationSettings('');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) async {
        if (details.payload != null) {
          log('notification payload: $details');
        }
        selectNotificationSubject.add(details.payload ?? 'empty payload');
      },
      onDidReceiveNotificationResponse: (details) async {
        if (details.payload != null) {
          log('notification payload: $details');
        }
        selectNotificationSubject.add(details.payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RestaurantModel restaurant,
  ) async {
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

    const titleNotification = '<b>Restaurant Recommendation</b>';
    final titleNews = restaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: json.encode(restaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        final data = RestaurantModel.fromJson(
          json.decode(payload) as Map<String, dynamic>,
        );
        Navigation.intentWithData(route, data);
      },
    );
  }
}
