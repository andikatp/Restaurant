import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    required this.restaurant,
    super.key,
  });

  final DetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    const dishType = ['Foods:', 'Drinks'];

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.only(left: 15),
            child: Text(
              dishType[0],
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
                  restaurant.menu.foods[index].name,
                  style: context.theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                color: MaterialStatePropertyAll(
                  Colours.primaryColor.withOpacity(0.95),
                ),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemCount: restaurant.menu.foods.length,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: REdgeInsets.only(left: 15),
            child: Text(
              dishType[1],
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
                  restaurant.menu.drinks[index].name,
                  style: context.theme.textTheme.bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                color: MaterialStatePropertyAll(
                  Colours.primaryColor.withOpacity(0.95),
                ),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemCount: restaurant.menu.drinks.length,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
