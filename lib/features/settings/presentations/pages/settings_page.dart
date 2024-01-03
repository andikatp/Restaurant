import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/services/noti.dart';
import 'package:dicoding_final/core/services/notification_helper.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/settings/presentations/provider/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Receive Notifications at 11 AM',
              style: context.theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SwitchWidget(),
          ],
        ),
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    super.key,
  });

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool newValue = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SchedulingProvider>(
      builder: (context, scheduled, child) => Switch.adaptive(
        value: newValue,
        onChanged: (value) async {
          context.messenger.removeCurrentSnackBar();
          context.messenger.showSnackBar(
            SnackBar(
              content: Text(
                value
                    ? 'Notifications Turned On. You will now receive daily '
                        'notifications at 11 AM.'
                    : "Notifications Turned Off. You won't receive daily "
                        'notifications.',
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
          setState(() {
            newValue = value;
          });
          // if (value) {
          //   await AndroidAlarmManager.periodic(
          //     const Duration(seconds: 5),
          //     2, // Unique identifier for this alarm
          //     fireAlarm,
          //     exact: true,
          //     wakeup: true,
          //   );
          // } else {
          //   await AndroidAlarmManager.cancel(2); // Cancel the alarm with ID 2
          // }
          // await scheduled.scheduledNews(value: value);
          if (value) {
            await NotificationHelper().showNotification(
              flutterLocalNotificationsPlugin,
              [
                const RestaurantModel(
                  id: 'id',
                  name: 'name',
                  description: 'description',
                  pictureId: 'pictureId',
                  city: 'city',
                  rating: 2,
                ),
              ],
            );
          }
        },
        activeColor: Colours.primaryColor,
        inactiveTrackColor: Colours.backgroundColor,
      ),
    );
  }
}

void fireAlarm() {
  print('alarm ${DateTime.now()}');
}
