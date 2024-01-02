import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Turn On Notification \nEvery 11 AM',
            style: context.theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            onPressed: () {
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 1,
                  channelKey: 'restaurant_channel',
                  title: 'Test Notification',
                  body: 'Yey, I have local notification working now!',
                ),
              );
            },
            icon: const Icon(Icons.notification_add),
            label: const Text('Press'),
          ),
        ],
      ),
    );
  }
}
