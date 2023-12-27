import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarDetail extends StatelessWidget {
  const AppBarDetail({
    required this.restaurant,
    super.key,
  });

  final DetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    void makeFavorite(String restaurantId) {
      // TODO(Saved): Create a save button
    }

    return SliverAppBar.large(
      title: Text(
        restaurant.name,
        style: context.theme.textTheme.headlineSmall,
      ),
      expandedHeight: Sizes.p300.h,
      leading: BackButton(
        color: Colours.primaryColor,
        style: ButtonStyle(
          iconSize: MaterialStatePropertyAll(Sizes.p36.sp),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => makeFavorite(restaurant.id),
          icon: Icon(
            Icons.bookmark_border,
            size: Sizes.p36.sp,
            color: Colours.primaryColor,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: restaurant.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Sizes.p28.r),
              bottomRight: Radius.circular(Sizes.p28.r),
            ),
            child: CachedNetworkImage(
              imageUrl: AppConstant.imageUrl + restaurant.pictureId,
              fit: BoxFit.fill,
              height: Sizes.p330.h,
              placeholder: (_, __) => const Center(
                child: CupertinoActivityIndicator(
                  color: Colours.primaryColor,
                ),
              ),
              errorWidget: (_, __, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
