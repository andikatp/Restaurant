import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/modal_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    required this.restaurant,
    required this.addReview,
    super.key,
  });

  final void Function(String restaurantId, String review) addReview;
  final DetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    const buttonText = 'See Review';
    const noTextDialogTitle = 'Review Required';
    const noTextDialogContent = 'Please enter a review before submitting.';
    const reviewAddedMessage = 'Review has been added!';
    const ok = 'Ok';

    void createReview(BuildContext currentContext) {
      if (controller.text.isEmpty) {
        showDialog<void>(
          context: currentContext,
          builder: (ctx) => AlertDialog(
            title: const Text(noTextDialogTitle),
            content: const Text(noTextDialogContent),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text(ok),
              ),
            ],
          ),
        );
      } else {
        addReview(restaurant.id, controller.text);
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.pop(currentContext);
        currentContext.messenger.showSnackBar(
          const SnackBar(
            content: Text(reviewAddedMessage),
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    void showReview() {
      modalReviewWidget(
        context: context,
        restaurant: restaurant,
        controller: controller,
        addReview: createReview,
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
                Icon(
                  Icons.location_on,
                  color: Colours.primaryColor,
                  size: Sizes.p24.sp,
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
                Icon(
                  Icons.star,
                  color: Colours.primaryColor,
                  size: Sizes.p24.sp,
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
