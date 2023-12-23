import 'dart:convert';
import 'package:dicoding_final/core/data_repository/fixture.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/restaurant/data/models/restaurants_model.dart';
import 'package:flutter/widgets.dart';

abstract class RestaurantLocalDataSource {
  const RestaurantLocalDataSource();

  /// Gets the list of [RestaurantModel] from dummy fixture reader
  ///
  /// Throws a dummy [CacheException] if the fixture error.
  Future<List<RestaurantModel>> getRestaurants();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final result = RestaurantsModel.fromJson(
        jsonDecode(fixture()) as Map<String, dynamic>,
      );
      final restaurants =
          result.restaurants.map((e) => e as RestaurantModel).toList();
      return Future.value(restaurants);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw CacheException(message: e.toString());
    }
  }
}
