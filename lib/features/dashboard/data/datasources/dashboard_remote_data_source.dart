import 'dart:convert';

import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/data/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class DashboardRemoteDataSource {
  const DashboardRemoteDataSource();

  /// Calls the https://restaurant-api.dicoding.dev/list endpoint.
  ///
  /// Throw a [ServerException] for all the error codes.
  Future<List<RestaurantModel>> getRestaurant();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  const DashboardRemoteDataSourceImpl({required http.Client client})
      : _client = client;
  final http.Client _client;

  @override
  Future<List<RestaurantModel>> getRestaurant() async {
    try {
      final response = await _client
          .get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

      if (response.statusCode != 200) {
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
}
