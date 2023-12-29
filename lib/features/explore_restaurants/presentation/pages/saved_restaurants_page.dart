import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/shared/restaurant_tile_widget.dart';
import 'package:dicoding_final/features/shared/saved_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SavedRestaurantPage extends StatelessWidget implements AutoRouteWrapper {
  const SavedRestaurantPage({super.key});

  static const routeName = '/saved';

  @override
  Widget build(BuildContext context) {
    final savedProvider = Provider.of<SavedProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Restaurants'),
      ),
      body: FutureBuilder(
        future: savedProvider.getSavedRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingIndicator();
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          } else {
            return _buildRestaurantList(savedProvider.restaurants);
          }
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'),
    );
  }

  Widget _buildRestaurantList(List<Restaurant> restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        // Use the RestaurantTileWidget here
        return RestaurantTile(restaurant: restaurant);
      },
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
