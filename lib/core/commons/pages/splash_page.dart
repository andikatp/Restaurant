import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  Future<Timer> startTime() async {
    const duration = Duration(seconds: 3);
    return Timer(
      duration,
      () => context.router.replaceNamed(AppNameRoute.restaurant),
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
