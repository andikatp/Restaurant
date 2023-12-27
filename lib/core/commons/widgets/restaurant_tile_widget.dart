import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/detail/presentation/pages/detail_page.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({
    required this.restaurant,
    super.key,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    void goToDetail(Restaurant restaurant) {
      context.focusScope.unfocus();
      context.navigator.pushNamed(
        DetailPage.routeName,
        arguments: restaurant.id,
      );
    }

    void makeFavorite(Restaurant restaurant) {
      // TODO(Saved): Create a save button
    }

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => goToDetail(restaurant),
        child: Container(
          padding: REdgeInsets.all(Sizes.p12).copyWith(left: Sizes.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: Sizes.p12.w,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Sizes.p12).r,
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: CachedNetworkImage(
                        imageUrl:
                            '${AppConstant.imageUrl}${restaurant.pictureId}',
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const Center(
                          child: CupertinoActivityIndicator(
                            color: Colours.primaryColor,
                          ),
                        ),
                        errorWidget: (_, __, error) => const Icon(Icons.error),
                        height: Sizes.p100.h,
                        width: Sizes.p100.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Sizes.p92.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: context.theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        RatingBarIndicator(
                          rating: restaurant.rating,
                          itemBuilder: (_, __) => const Icon(
                            Icons.star,
                            color: Colours.primaryColor,
                          ),
                          itemSize: Sizes.p24.w,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                            color: Colours.primaryColor,
                            size: Sizes.p16,
                            ),
                            Text(
                              restaurant.city,
                              style: context.theme.textTheme.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => makeFavorite(restaurant),
                icon: Icon(
                  Icons.bookmark_border_outlined,
                  size: Sizes.p36.sp,
                  color: Colours.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
