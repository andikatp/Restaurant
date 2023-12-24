import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/appbar_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  static const routeName = 'home';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  void initState() {
    context.read<RestaurantCubit>().getRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RestaurantCubit, RestaurantState>(
          listener: (context, state) {
            if (state is RestaurantError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return const LoadingWidget();
            }
            if (state is RestaurantLoaded) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  appBarWidget(context),
                  SliverAnimatedList(
                    initialItemCount: state.restaurants.length,
                    itemBuilder: (context, index, animation) {
                      final restaurants = state.restaurants[index];
                      return Container(
                        margin: REdgeInsets.only(bottom: 10),
                        color: Colors.white,
                        padding: REdgeInsets.all(12).copyWith(left: 20),
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 10.w,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12).r,
                                  child: CachedNetworkImage(
                                    imageUrl: restaurants.pictureId,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const Center(
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
                                SizedBox(
                                  height: 90,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        restaurants.name,
                                        style: context
                                            .theme.textTheme.titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      RatingBarIndicator(
                                        rating: restaurants.rating,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colours.secondaryColor,
                                        ),
                                        itemSize: 25.w,
                                      ),
                                      Text(
                                        restaurants.city,
                                        style: context
                                            .theme.textTheme.labelLarge,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
