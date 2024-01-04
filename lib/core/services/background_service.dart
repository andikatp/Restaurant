import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/core/services/notification_service.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/remote/explore_restaurants_remote_data_source.dart';

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

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    try {
      await setupDependencyInjectionInIsolate();
      log('Alarm fired!');
      final notificationService = NotificationService();
      final result =
          await sl<ExploreRestaurantsRemoteDataSourceImpl>().getRestaurants();
      await notificationService.showNotification(
        title: result[0].name,
        body: result[0].description,
        payload: result[0].id,
      );
      _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
      _uiSendPort?.send(null);
    } catch (e, stackTrace) {
      log('Error in isolate: $e\n$stackTrace');
    }
  }

  static Future<void> setupDependencyInjectionInIsolate() async {
    log('Initializing dependencies in isolate');
    await init();
    log('Dependencies initialized in isolate');
  }
}
