import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:dicoding_final/features/restaurant/presentation/pages/detail_page.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/appbar_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  static const routeName = 'home';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    context.read<RestaurantCubit>().getRestaurants();
  }

  void search(String restaurant) =>
      context.read<RestaurantCubit>().searchRestaurants(restaurant);

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
                  appBarWidget(
                    ctx: context,
                    controller: _controller,
                    search: search,
                  ),
                  if (state.restaurants.isEmpty)
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          children: [
                            Lottie.asset(
                              'assets/data_repository/empty.json',
                            ),
                            Text(
                              'Restaurant not found. \nPlease check the name!',
                              textAlign: TextAlign.center,
                              style: context.theme.textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ]),
                    ),
                  SliverList.separated(
                    itemCount: state.restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = state.restaurants[index];
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
                                            restaurant.name,
                                            style: context
                                                .theme.textTheme.titleMedium,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          RatingBarIndicator(
                                            rating: restaurant.rating,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colours.secondaryColor,
                                            ),
                                            itemSize: 25.w,
                                          ),
                                          Text(
                                            restaurant.city,
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
                                IconButton(
                                  onPressed: () {
                                    // TODO(Saved): Create a save button
                                  },
                                  icon: const Icon(
                                    Icons.bookmark_border_outlined,
                                    size: 35,
                                    color: Colours.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(
                      height: 10.h,
                    ),
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
