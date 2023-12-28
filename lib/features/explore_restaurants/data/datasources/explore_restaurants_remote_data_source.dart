import 'dart:convert';

import 'package:dicoding_final/core/constants/api_endpoint.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ExploreRestaurantsRemoteDataSource {
  const ExploreRestaurantsRemoteDataSource();

  /// Calls the https://restaurant-api.dicoding.dev/list endpoint.
  ///
  /// Throw a [ServerException] for all the error codes.
  Future<List<RestaurantModel>> getRestaurants();

  /// Calls the https://restaurant-api.dicoding.dev/search?q=<query> endpoint.
  ///
  /// Throw a [ServerException] for all the error codes.
  Future<List<RestaurantModel>> searchRestaurant(String restaurantName);
}

class ExploreRestaurantsRemoteDataSourceImpl
    implements ExploreRestaurantsRemoteDataSource {
  const ExploreRestaurantsRemoteDataSourceImpl({required http.Client client})
      : _client = client;
  final http.Client _client;

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      final url =
          Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.allRestaurants}');
      final response = await _client.get(url);

      if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
        throw ServerException(message: response.body);
      }

      final decode = jsonDecode(response.body) as ResultMap;
      if (decode['error'] == true) {
        throw ServerException(message: decode['message'] as String);
      }

      final result = (decode['restaurants'] as List<dynamic>)
          .map((e) => RestaurantModel.fromJson(e as ResultMap))
          .toList();

      return result;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<RestaurantModel>> searchRestaurant(String restaurantName) async {
    try {
      final url = Uri.parse(
        '${AppConstant.baseUrl}${ApiEndpoint.searchRestaurants}$restaurantName',
      );
      final response = await _client.get(url);

      if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
        throw ServerException(message: response.body);
      }

      final decode = jsonDecode(response.body) as ResultMap;
      if (decode['error'] == true) {
        throw ServerException(message: response.body);
      }
      final result = (decode['restaurants'] as List<dynamic>)
          .map(
            (restaurant) => RestaurantModel.fromJson(restaurant as ResultMap),
          )
          .toList();
      return result;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString());
    }
  }
}
