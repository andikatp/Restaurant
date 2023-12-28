import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/commons/widgets/network_error_widget.dart';
import 'package:dicoding_final/core/commons/widgets/restaurant_tile_widget.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/home_widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  static const routeName = 'dashboard';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    context.read<ExploreRestaurantsCubit>().getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ExploreRestaurantsCubit, ExploreRestaurantsState>(
          listener: (context, state) {
            if (state is GetRestaurantsError) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is GetRestaurantsLoading) {
              return const LoadingWidget();
            }
            if (state is GetRestaurantsLoaded) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const AppBarWidget(),
                  SliverList.separated(
                    itemCount: state.restaurants.length,
                    itemBuilder: (_, index) {
                      final restaurant = state.restaurants[index];
                      return RestaurantTile(restaurant: restaurant);
                    },
                    separatorBuilder: (_, __) => Gap.h8,
                  ),
                ],
              );
            }
            return NetworkErrorWidget(onRetry: fetchData);
          },
        ),
      ),
    );
  }
}
