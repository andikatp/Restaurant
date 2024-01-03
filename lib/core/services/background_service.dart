import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/core/services/notification_helper.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/remote/explore_restaurants_remote_data_source.dart';
import 'package:dicoding_final/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  factory BackgroundService() => _instance ?? BackgroundService._internal();

  BackgroundService._internal() {
    _instance = this;
  }
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    log('Alarm fired!');
    final notificationHelper = NotificationHelper();
    final result =
        sl<ExploreRestaurantsRemoteDataSourceImpl>().getRestaurants();
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      await result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
