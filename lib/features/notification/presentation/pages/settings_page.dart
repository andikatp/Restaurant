import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/notification/presentation/provider/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SchedulingProvider>().isScheduledOn();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              runSpacing: Sizes.p16,
              children: [
                Lottie.asset(AppConstant.bellLottie, height: Sizes.p152),
                Text(
                  AppConstant.settingText,
                  style: context.theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SwitchWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SchedulingProvider>(
      builder: (context, scheduled, child) {
        if (scheduled.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              scheduled.errorMessage,
              textAlign: TextAlign.center,
            ),
          );
        }
        return Switch.adaptive(
          value: scheduled.isScheduled,
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
            await scheduled.scheduledRestaurant(value: value);
          },
          activeColor: Colours.primaryColor,
          inactiveTrackColor: Colours.backgroundColor,
        );
      },
    );
  }
}
