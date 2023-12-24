import 'dart:convert';
import 'package:dicoding_final/core/data_repository/fixture.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/restaurant/data/models/restaurants_model.dart';
import 'package:flutter/widgets.dart';

abstract class RestaurantLocalDataSource {
  const RestaurantLocalDataSource();

  /// Retrieves the list of [RestaurantModel] from the dummy fixture reader.
  ///
  /// Returns a [Future] that completes with a list of [RestaurantModel] when
  /// the retrieval is successful.
  /// Throws a [CacheException] if an error occurs while reading the dummy
  /// fixture.
  Future<List<RestaurantModel>> getRestaurants();

  /// Searches for restaurants in the list of [RestaurantModel] using the dummy
  /// fixture reader.
  ///
  /// Returns a [Future] that completes with a list of [RestaurantModel] when
  /// the search is successful.
  /// Throws a [CacheException] if an error occurs while reading the dummy
  /// fixture.
  Future<List<RestaurantModel>> searchRestaurant(String search);
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      final decode = jsonDecode(await fixture())as Map<String, dynamic>;
      final result = RestaurantsModel.fromJson( decode );
      final restaurants =
          result.restaurants.map((e) => e as RestaurantModel).toList();
      return restaurants;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<List<RestaurantModel>> searchRestaurant(String search) async {
    try {
      final decode = jsonDecode(await fixture())as Map<String, dynamic>;
      final result = RestaurantsModel.fromJson(decode);
      final restaurants =
          result.restaurants.map((e) => e as RestaurantModel).toList();
      final filteredRestaurants = restaurants
          .where(
            (restaurant) =>
                restaurant.name.toLowerCase().contains(search.toLowerCase()),
          )
          .toList();
      return filteredRestaurants;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(message: e.toString());
    }
  }
}
