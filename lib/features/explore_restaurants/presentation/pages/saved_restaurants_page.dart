import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/shared/lottie_state.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/shared/appbar.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/shared/restaurant_tile_widget.dart';
import 'package:dicoding_final/features/shared/saved_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SavedRestaurantPage extends StatelessWidget {
  const SavedRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    void searchSavedRestaurant(String query) =>
        context.read<SavedProvider>().searchSavedRestaurant(query);

    return Center(
      child: CustomScrollView(
        slivers: [
          AppBarWidget(searchRestaurant: searchSavedRestaurant),
          Consumer<SavedProvider>(
            builder: (context, provider, _) {
              if (provider.restaurants.isEmpty) {
                return const LottieState(
                  lottieAsset: AppConstant.emptySavedLottie,
                  text: AppConstant.initialSavedText,
                );
              }
              if (provider.messageOfError.isNotEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      provider.messageOfError,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return SliverList.separated(
                itemCount: provider.restaurants.length,
                itemBuilder: (_, index) {
                  final restaurant = provider.restaurants[index];
                  return RestaurantTile(restaurant: restaurant);
                },
                separatorBuilder: (_, __) => Gap.h8,
              );
            },
          ),
        ],
      ),
    );
  }
}
