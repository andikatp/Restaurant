import 'package:dicoding_final/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SliverAppBar appBarWidget({
  required BuildContext ctx,
  required TextEditingController controller,
  required void Function(String) search,
}) =>
    SliverAppBar(
      toolbarHeight: 80.h,
      floating: true,
      title: TextField(
        controller: controller,
        onChanged: (String value) => search(value),
        onTapOutside: (_) => FocusScope.of(ctx).unfocus(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15).r,
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          fillColor: Colours.greyColor,
          filled: true,
          hintText: 'Search',
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
            backgroundImage: AssetImage('assets/logo/german.png'),
          ),
        ),
      ],
    );
