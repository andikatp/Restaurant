import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';

class SaveRestaurant implements UseCaseWithParams<void, Restaurant> {
  const SaveRestaurant({required ExploreRestaurantsRepo repo})
      : _repo = repo;
  final ExploreRestaurantsRepo _repo;

  @override
  ResultFuture<void> call(Restaurant restaurant) {
    return _repo.saveRestaurant(restaurant);
  }
}
