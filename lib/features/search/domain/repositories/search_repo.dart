import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';

abstract class SearchRepo {
  const SearchRepo();
  ResultFuture<List<Restaurant>> searchRestaurant(String restaurantName);
}
