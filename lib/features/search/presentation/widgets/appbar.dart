import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    required this.controller,
    required this.searchRestaurant,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String restaurantName) searchRestaurant;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: Sizes.p72,
      title: Hero(
        tag: AppConstant.hintText,
        child: Material(
          type: MaterialType.transparency,
          child: TextField(
            autofocus: true,
            controller: controller,
            onChanged: searchRestaurant,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(Sizes.p16).r,
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              fillColor: Colours.greyColor,
              filled: true,
              hintText: AppConstant.hintText,
              prefixIcon: Icon(
                Icons.search,
                color: Colours.secondaryGreyColor,
                size: Sizes.p24.sp,
              ),
              suffixIcon: const Icon(
                Icons.mic,
                color: Colours.secondaryGreyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
