import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';

abstract class ExploreRestaurantsRepo {
  const ExploreRestaurantsRepo();
  ResultFuture<List<Restaurant>> getRestaurants();
  ResultFuture<List<Restaurant>> searchRestaurants(String restaurantName);
}
