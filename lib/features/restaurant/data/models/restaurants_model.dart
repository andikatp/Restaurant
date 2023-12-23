import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurants.dart';

class RestaurantsModel extends Restaurants {
  const RestaurantsModel({required List<RestaurantModel> restaurants})
      : super(restaurants: restaurants);

  factory RestaurantsModel.toJson(Map<String, dynamic> json) =>
      RestaurantsModel(
        restaurants: (json['restaurants'] as List<dynamic>)
            .map(
              (restaurant) =>
                  RestaurantModel.fromJson(restaurant as Map<String, dynamic>),
            )
            .toList(),
      );
}
