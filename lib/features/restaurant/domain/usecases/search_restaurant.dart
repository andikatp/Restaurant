import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/repositories/restaurant_repo.dart';

class SearchRestaurant implements UseCase<List<Restaurant>> {
  const SearchRestaurant({required RestaurantRepo repo}) : _repo = repo;
  final RestaurantRepo _repo;

  @override
  ResultFuture<List<Restaurant>> call() {
    return _repo.getRestaurants();
  }
}
