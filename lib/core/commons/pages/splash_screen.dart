import 'dart:async';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/res/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  Future<Timer> startTime() async {
    const duration = Duration(seconds: 3);
    return Timer(
      duration,
      () => context.modalRoute!.navigator!
          .pushReplacementNamed(AppRoutes.dashboardPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    const assetPath = 'assets/logo/logo.svg';

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetPath,
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}
