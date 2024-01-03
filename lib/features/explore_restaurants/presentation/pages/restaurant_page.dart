import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/commons/widgets/network_error_widget.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/home_widget/appbar_widget.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/shared/restaurant_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RestaurantPage extends StatelessWidget implements AutoRouteWrapper {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExploreRestaurantsCubit>()..getRestaurants();

    return SafeArea(
      child: BlocBuilder<ExploreRestaurantsCubit, ExploreRestaurantsState>(
        builder: (context, state) {
          if (state is GetRestaurantsLoading) {
            return const LoadingWidget();
          }
          if (state is GetRestaurantsLoaded) {
            return buildSliverList(state.restaurants);
          }
          if (state is GetRestaurantsError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            });
            return NetworkErrorWidget(onRetry: cubit.getRestaurants);
          }
          return NetworkErrorWidget(
            onRetry: cubit.getRestaurants,
          );
        },
      ),
    );
  }

  Widget buildSliverList(List<Restaurant> restaurants) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const AppBarWidget(),
        SliverList.separated(
          itemCount: restaurants.length,
          itemBuilder: (_, index) {
            final restaurant = restaurants[index];
            return RestaurantTile(restaurant: restaurant);
          },
          separatorBuilder: (_, __) => Gap.h8,
        ),
      ],
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ExploreRestaurantsCubit>(
      create: (_) => sl<ExploreRestaurantsCubit>(),
      child: this,
    );
  }
}
