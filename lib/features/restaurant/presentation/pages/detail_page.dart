import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final restaurant = context.modalRoute!.settings.arguments! as Restaurant;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              restaurant.name,
              style: context.theme.textTheme.headlineSmall,
            ),
            expandedHeight: 300.h,
            leading: const BackButton(
              color: Colours.secondaryColor,
              style: ButtonStyle(
                iconSize: MaterialStatePropertyAll(35),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border,
                  size: 35,
                  color: Colours.secondaryColor,
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
                  placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(
                      color: Colours.secondaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.only(left: 15),
                  child: Text(
                    'Foods:',
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
                    itemBuilder: (context, index) =>
                        Chip(label: Text(restaurant.menus.foods[index].name)),
                    separatorBuilder: (_, __) => SizedBox(width: 10.w),
                    itemCount: restaurant.menus.foods.length,
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: REdgeInsets.only(left: 15),
                  child: Text(
                    'Drinks:',
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
                      label: Text(restaurant.menus.drinks[index].name),
                    ),
                    separatorBuilder: (_, __) => SizedBox(width: 10.w),
                    itemCount: restaurant.menus.drinks.length,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
