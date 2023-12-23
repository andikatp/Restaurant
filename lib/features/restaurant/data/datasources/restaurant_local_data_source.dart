import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';

abstract class RestaurantLocalDataSource {
  const RestaurantLocalDataSource();
  Future<List<RestaurantModel>> getRestaurants();
}
