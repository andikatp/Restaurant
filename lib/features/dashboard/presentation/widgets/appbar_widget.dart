import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/res/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    const assetImage = 'assets/logo/german.png';
    const hintText = 'Search';

    void goToSearchPage() => context.navigator.pushNamed(AppRoutes.searchPage);

    return SliverAppBar(
      toolbarHeight: 80.h,
      floating: true,
      title: TextField(
        controller: controller,
        readOnly: true,
        onTap: goToSearchPage,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15).r,
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          fillColor: Colours.greyColor,
          filled: true,
          hintText: hintText,
          prefixIcon: Icon(
            Icons.search,
            color: Colours.secondaryGreyColor,
            size: 25.sp,
          ),
          suffixIcon: const Icon(
            Icons.mic,
            color: Colours.secondaryGreyColor,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: const CircleAvatar(
            backgroundImage: AssetImage(assetImage),
          ),
        ),
      ],
    );
  }
}
