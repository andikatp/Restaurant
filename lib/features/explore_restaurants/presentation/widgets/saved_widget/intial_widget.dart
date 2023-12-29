import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class InitialState extends StatelessWidget {
  const InitialState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppConstant.emptySavedLottie,
              height: Sizes.p300.h,
              fit: BoxFit.cover,
            ),
            Gap.h12,
            Text(
              AppConstant.initialSavedText,
              style: context.theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Gap.h20,
          ],
        ),
      ),
    );
  }
}
