import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({required this.onRetry, super.key});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/json/network_error.json',
            height: 200.h,
            fit: BoxFit.cover,
          ),
          Gap.h24,
          Text(
            AppConstant.noInternetConnection,
            style: context.theme.textTheme.headlineSmall,
          ),
          Gap.h24,
          ElevatedButton(onPressed: onRetry, child: const Text('Try Again')),
        ],
      ),
    );
  }
}
