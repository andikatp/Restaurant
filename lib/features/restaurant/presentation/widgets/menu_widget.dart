import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    required this.restaurant, super.key,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.only(left: 15),
            child: Text(
              'Foods:',
              style: context.theme.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 50.h,
            child: ListView.separated(
              padding: REdgeInsets.only(left: 15, right: 15),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Chip(
                label: Text(
                  restaurant.menus.foods[index].name,
                  style: context.theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                color: const MaterialStatePropertyAll(
                  Colours.secondaryColor,
                ),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemCount: restaurant.menus.foods.length,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: REdgeInsets.only(left: 15),
            child: Text(
              'Drinks:',
              style: context.theme.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 50.h,
            child: ListView.separated(
              padding: REdgeInsets.only(left: 15, right: 15),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Chip(
                label: Text(
                  restaurant.menus.drinks[index].name,
                  style: context.theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                color: const MaterialStatePropertyAll(
                  Colours.secondaryColor,
                ),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemCount: restaurant.menus.drinks.length,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
