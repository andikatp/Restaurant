import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<Widget?> modalReviewWidget({
  required BuildContext context,
  required DetailRestaurant restaurant,
  required TextEditingController controller,
  required void Function(BuildContext context) addReview,
}) {
  return showModalBottomSheet<Widget>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: Container(
        width: double.infinity,
        height: Sizes.p400.h,
        padding: REdgeInsets.all(Sizes.p20),
        child: Column(
          children: [
            Container(
              height: Sizes.p8.h,
              width: Sizes.p24.w,
              decoration: BoxDecoration(
                color: Colours.secondaryGreyColor,
                borderRadius:
                    BorderRadius.all(const Radius.circular(Sizes.p16).r),
              ),
            ),
            Gap.h12,
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.transparent, Colors.white],
                stops: [0.0, 0.03],
              ).createShader(bounds),
              child: SizedBox(
                height: Sizes.p280.h,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage(
                          AppConstant.userImagePath,
                        ),
                        radius: Sizes.p24.r,
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
                              style:
                                  context.theme.textTheme.labelSmall!.copyWith(
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
                  separatorBuilder: (_, __) => Gap.h12,
                  itemCount: restaurant.customerReviews.length,
                ),
              ),
            ),
            const Spacer(),
            TextField(
              onSubmitted: (_) => addReview(ctx),
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(const Radius.circular(Sizes.p20).r),
                ),
                hintText: AppConstant.addCommentText,
                contentPadding: REdgeInsets.all(Sizes.p12),
                isDense: true,
                suffixIcon: Transform.rotate(
                  angle: 3.14 / 2,
                  child: IconButton(
                    onPressed: () => addReview(ctx),
                    icon: const Icon(Icons.arrow_circle_left),
                    iconSize: Sizes.p32.sp,
                    color: Colours.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
