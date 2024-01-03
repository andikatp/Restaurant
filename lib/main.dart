import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_final/core/res/theme.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:dicoding_final/core/services/background_service.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/shared/saved_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundService().initializeIsolate();
  await AndroidAlarmManager.initialize();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = sl<AppRouter>();

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
