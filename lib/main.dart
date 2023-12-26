import 'package:dicoding_final/core/commons/pages/splash_screen.dart';
import 'package:dicoding_final/core/res/routes.dart';
import 'package:dicoding_final/core/res/theme.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      minTextAdapt: true,
      builder: (_, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: 'Restaurant',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.currentTheme,
          routes: AppRoutes.routes,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
