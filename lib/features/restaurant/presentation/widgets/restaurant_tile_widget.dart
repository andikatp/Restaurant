import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/presentation/pages/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({
    required this.restaurant, super.key,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => context.navigator.pushNamed(
          DetailPage.routeName,
          arguments: restaurant,
        ),
        child: Container(
          padding: REdgeInsets.all(12).copyWith(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 10.w,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12).r,
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: CachedNetworkImage(
                        imageUrl: restaurant.pictureId,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(
                            color: Colours.secondaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        height: 100.h,
                        width: 100.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
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
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colours.secondaryColor,
                          ),
                          itemSize: 25.w,
                        ),
                        Text(
                          restaurant.city,
                          style: context.theme.textTheme.labelLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  // TODO(Saved): Create a save button
                },
                icon: Icon(
                  Icons.bookmark_border_outlined,
                  size: 35.sp,
                  color: Colours.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
