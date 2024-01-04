import 'dart:convert';
import 'dart:developer';
import 'package:dicoding_final/core/navigation/navigation.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static bool _isInitialized = false;

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
    final flutterLocalNotificationsPlugin =
        sl<FlutterLocalNotificationsPlugin>();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        log('Received notification response. Payload: ${details.payload}');
        if (details.payload != null) {
          Navigation.intentWithData(
            DetailRoute(restaurantId: details.payload!),
          );
        }
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
    final flutterLocalNotificationsPlugin =
        sl<FlutterLocalNotificationsPlugin>();
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
      payload: payload,
    );
  }

  static Future<void> callback() async {
    log('cb called');
    await setupDependencyInjectionInIsolate();
    final restaurant = RestaurantModel.fromJson(
      jsonDecode(sl<SharedPreferences>().getString('currentRestaurant')!)
          as ResultMap,
    );
    await NotificationService().showNotification(
      title: restaurant.name,
      body: restaurant.description,
      payload: restaurant.id,
    );
  }

  static Future<void> setupDependencyInjectionInIsolate() async {
    if (!_isInitialized) {
      await init();
      _isInitialized = true;
    }
  }
}
