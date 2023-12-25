import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    required this.restaurant, super.key,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: REdgeInsets.symmetric(horizontal: 15, vertical: 10),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Text(
              restaurant.name,
              style: context.theme.textTheme.headlineSmall,
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
              style: context.theme.textTheme.titleMedium,
            ),
            SizedBox(height: 20.h),
            Text(
              restaurant.description,
              style: context.theme.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
