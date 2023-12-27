import 'package:cached_network_image/cached_network_image.dart';
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
    return SliverAppBar.large(
      title: Text(
        restaurant.name,
        style: context.theme.textTheme.headlineSmall,
      ),
      expandedHeight: 300.h,
      leading: BackButton(
        color: Colours.primaryColor,
        style: ButtonStyle(
          iconSize: MaterialStatePropertyAll(35.sp),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO(Saved): Create a save button
          },
          icon: Icon(
            Icons.bookmark_border,
            size: 35.sp,
            color: Colours.primaryColor,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: restaurant.pictureId,
          child: CachedNetworkImage(
            imageUrl: restaurant.pictureId,
            fit: BoxFit.fill,
            height: 330.h,
            placeholder: (_, __) => const Center(
              child: CupertinoActivityIndicator(
                color: Colours.primaryColor,
              ),
            ),
            errorWidget: (_, __, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
