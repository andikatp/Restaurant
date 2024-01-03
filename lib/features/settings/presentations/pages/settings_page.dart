import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:flutter/material.dart';

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
    return Switch(
      value: newValue,
      onChanged: (value) {
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
        setState(() => newValue = value);
      },
      activeColor: Colours.primaryColor,
      inactiveTrackColor: Colours.backgroundColor,
    );
  }
}
