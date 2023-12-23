import 'package:dicoding_final/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget appBarWidget() => AppBar(
      toolbarHeight: 80.h,
      title: TextField(
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
