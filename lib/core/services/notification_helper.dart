import 'dart:convert';
import 'dart:developer';
import 'package:dicoding_final/core/navigation/navigation.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
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
    const initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        // Navigation.intentWithData(DetailRoute.name, 'rqdv5juczeskfw1e867');
        if (payload.payload != null) {
          log('notification payload: ${payload.payload}');
        }
        selectNotificationSubject.add(payload.payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    List<RestaurantModel> restaurant,
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

    const titleNotification = '<b>Daily Restaurant Near You!</b>';
    final titleNews = restaurant[0].name;

    final restaurantList = restaurant.map((e) => e.toJson()).toList();

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: json.encode({'restaurants': restaurantList}),
    );
  }
}
