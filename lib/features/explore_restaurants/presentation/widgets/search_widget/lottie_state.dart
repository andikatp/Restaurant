import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieState extends StatelessWidget {
  const LottieState({
    required this.lottieAsset, super.key,
  });
  final String lottieAsset;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieAsset,
            height: Sizes.p300.h,
            fit: BoxFit.cover,
          ),
          Gap.h12,
          Text(
            AppConstant.searchText,
            style: context.theme.textTheme.headlineSmall,
          ),
          Gap.h20,
        ],
      ),
    );
  }
}
