import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dicoding_final/core/res/theme.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:dicoding_final/core/services/background_service.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/core/services/notification_controller.dart';
import 'package:dicoding_final/features/shared/saved_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(
    '',
    [
      NotificationChannel(
        channelGroupKey: 'restaurant_channel_group',
        channelKey: 'restaurant_channel',
        channelName: 'restaurant',
        channelDescription: 'restaurant notification',
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'restaurant_channel_group',
        channelGroupName: 'restaurant_group',
      ),
    ],
  );
  final isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
  BackgroundService().initializeIsolate();
  await AndroidAlarmManager.initialize();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = sl<AppRouter>();

  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      minTextAdapt: true,
      builder: (_, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ChangeNotifierProvider(
          create: (_) => sl<SavedProvider>(),
          child: MaterialApp.router(
            title: 'Restaurant',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.currentTheme,
            routerConfig: _router.config(),
          ),
        ),
      ),
    );
  }
}
