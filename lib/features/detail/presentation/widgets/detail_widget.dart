import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    required this.restaurant,
    super.key,
  });

  final DetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: REdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p8),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Text(
              restaurant.name,
              style: context.theme.textTheme.headlineMedium,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colours.primaryColor,
                  size: Sizes.p24,
                ),
                Gap.w8,
                Text(
                  restaurant.city,
                  style: context.theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap.w8,
                Expanded(
                  child: Text(
                    '- ${restaurant.address}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colours.primaryColor,
                  size: Sizes.p24,
                ),
                Gap.w8,
                Text(
                  restaurant.rating.toString(),
                  style: context.theme.textTheme.labelLarge,
                ),
                Gap.w8,
                Text(
                  '(${restaurant.customerReviews.length}+)',
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: Colours.secondaryGreyColor,
                  ),
                ),
                Gap.w8,
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    'See Review',
                    style: TextStyle(
                      color: Colours.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Sizes.p48.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Chip(
                  label: Text(
                    restaurant.categories[index].name,
                    style: context.theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  color: MaterialStatePropertyAll(
                    Colours.primaryColor.withOpacity(0.95),
                  ),
                ),
                separatorBuilder: (_, __) => Gap.w8,
                itemCount: restaurant.categories.length,
              ),
            ),
            Gap.h20,
            const Divider(),
            Text(
              restaurant.description,
              style: context.theme.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const Divider(),
            Gap.h16,
          ],
        ),
      ),
    );
  }
}
