import 'dart:convert';

import 'package:dicoding_final/core/data_repository/fixture.dart';
import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';

abstract class RestaurantLocalDataSource {
  const RestaurantLocalDataSource();
  Future<List<RestaurantModel>> getRestaurants();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    throw UnimplementedError();
  }
}
