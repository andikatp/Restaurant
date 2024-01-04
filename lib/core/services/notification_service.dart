import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/navigation/navigation.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ReceivePort port = ReceivePort();

class NotificationService {
  static bool _isInitialized = false;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> initialize() async {
    try {
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

      _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
      _uiSendPort?.send(null);
    } catch (e, stackTrace) {
      log('Error in isolate: $e\n$stackTrace');
    }
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
    final restaurantList = sl<SharedPreferences>()
        .getStringList(AppConstant.restaurantsListKey)
        ?.map(
          (jsonString) =>
              RestaurantModel.fromJson(jsonDecode(jsonString) as ResultMap),
        )
        .toList();

    restaurantList?.shuffle();
    final restaurant = restaurantList?[0];

    await NotificationService().showNotification(
      title: restaurant?.name ?? 'No Name',
      body: AppConstant.notificationDetail,
      payload: restaurant?.id ?? 'rqdv5juczeskfw1e867',
    );
  }

  static Future<void> setupDependencyInjectionInIsolate() async {
    if (!_isInitialized) {
      await init();
      _isInitialized = true;
    }
  }
}
