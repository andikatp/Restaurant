import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/navigation/navigation.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Noti {
  static Future<void> initialize() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        log('Received notification response. Payload: ${details.payload}');
        //  context.routeData.push(DetailRoute(restaurantId: details.payload!));
        // Navigation.intentWithData(DetailRoute.name, 'rqdv5juczeskfw1e867');
        Navigation.intentWithData(
          DetailRoute(restaurantId: 'rqdv5juczeskfw1e867'),
        );
      },
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
