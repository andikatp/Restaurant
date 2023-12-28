import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';

class SearchRestaurant implements UseCaseWithParams<List<Restaurant>, String> {
  const SearchRestaurant({required ExploreRestaurantsRepo repo}) : _repo = repo;
  final ExploreRestaurantsRepo _repo;

  @override
  ResultFuture<List<Restaurant>> call(String restaurantName) {
    return _repo.searchRestaurants(restaurantName);
  }
}
