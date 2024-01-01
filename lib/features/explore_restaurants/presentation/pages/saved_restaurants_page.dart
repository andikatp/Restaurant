import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/search_widget/lottie_state.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/shared/restaurant_tile_widget.dart';
import 'package:dicoding_final/features/shared/saved_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SavedRestaurantPage extends StatelessWidget {
  const SavedRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        slivers: [
          FutureBuilder(
            future: context.read<SavedProvider>().getSavedRestaurant(),
            builder: (context, snapshot) {
              final restaurants = context.read<SavedProvider>().restaurants;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: LoadingWidget(),
                );
              }
              if (restaurants.isEmpty) {
                return const LottieState(
                  lottieAsset: AppConstant.emptySavedLottie,
                  text: AppConstant.initialSavedText,
                );
              }
              if (restaurants.isNotEmpty) {
                return SliverList.separated(
                  itemCount: restaurants.length,
                  itemBuilder: (_, index) {
                    final restaurant = restaurants[index];
                    return RestaurantTile(restaurant: restaurant);
                  },
                  separatorBuilder: (_, __) => Gap.h8,
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
