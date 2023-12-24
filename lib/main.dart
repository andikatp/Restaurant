// import 'package:dicoding_final/core/commons/pages/splash_screen.dart';
import 'package:dicoding_final/core/res/routes.dart';
import 'package:dicoding_final/core/res/theme.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:dicoding_final/features/restaurant/presentation/pages/restaurants_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (context) => sl<RestaurantCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(412, 732),
        minTextAdapt: true,
        builder: (_, child) => MaterialApp(
          title: 'Restaurant',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.currentTheme,
          routes: AppRoutes.routes,
          // home: FutureBuilder(
          //   future: Future<void>.delayed(const Duration(seconds: 3)),
          //   builder: (context, snapshot) =>
          //       snapshot.connectionState == ConnectionState.waiting
          //           ? const SplashScreen()
          //           : const RestaurantPage(),
          // ),
          home: const RestaurantPage(),
        ),
      ),
    );
  }
}
