import 'dart:async';
import 'package:dicoding_final/core/constants/app_constant.dart';
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
          .pushReplacementNamed(AppRoutes.home),
    );
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor: Colours.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppConstant.logoPath,
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}
