import 'package:dicoding_final/core/commons/pages/splash_screen.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/res/fonts.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/restaurant/presentation/pages/restaurants_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      minTextAdapt: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: AppFonts.textTheme,
          primaryColor: Colours.primaryColor,
          colorScheme: theme.colorScheme.copyWith(
            primary: Colours.primaryColor,
            secondary: Colours.secondaryColor,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
