import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    required this.restaurant,
    super.key,
  });

  final DetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    const buttonText = 'See Review';

    void showReview() {
      showModalBottomSheet<Widget>(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            height: Sizes.p400,
            padding: REdgeInsets.all(Sizes.p20),
            child: Column(
              children: [
                Container(
                  height: Sizes.p8,
                  width: Sizes.p24,
                  decoration: const BoxDecoration(
                    color: Colours.secondaryGreyColor,
                    borderRadius: BorderRadius.all(Radius.circular(Sizes.p16)),
                  ),
                ),
                Gap.h12,
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.transparent, Colors.white],
                    stops: [0.0, 0.05],
                  ).createShader(bounds),
                  child: SizedBox(
                    height: Sizes.p280,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              AppConstant.userImagePath,
                            ),
                            radius: Sizes.p24,
                          ),
                          Gap.w16,
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.customerReviews[index].name,
                                  style: context.theme.textTheme.labelLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  restaurant.customerReviews[index].review,
                                  style: context.theme.textTheme.labelMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  restaurant.customerReviews[index].date,
                                  style: context.theme.textTheme.labelSmall!
                                      .copyWith(
                                    color: Colours.secondaryGreyColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => Gap.h12,
                      itemCount: restaurant.customerReviews.length,
                    ),
                  ),
                ),
                const Spacer(),
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Sizes.p20)),
                    ),
                    hintText: 'Add Comment',
                    contentPadding: REdgeInsets.all(Sizes.p12),
                    isDense: true,
                    suffixIcon: Transform.rotate(
                      angle: 3.14 / 2,
                      child: const Icon(
                        Icons.arrow_circle_left,
                        size: Sizes.p32,
                        color: Colours.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
              // Container(
              //   child: Row(
              //     children: [

              //

              //       ),
              //     ],
              //   ),
              // ),
            ),
          ),
        ),
      );
    }

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
                  onPressed: showReview,
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    buttonText,
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
