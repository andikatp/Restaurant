import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';

abstract class RestaurantRepo {
  const RestaurantRepo();
  ResultFuture<List<Restaurant>> getRestaurants();
}
