import 'dart:convert';

import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/dashboard/domain/entities/restaurant.dart';
import 'package:http/http.dart' as http;

abstract class DetailRemoteDataSource {
  const DetailRemoteDataSource();

  Future<Restaurant> getDetailRestaurant(String id);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  DetailRemoteDataSourceImpl({required http.Client client}) : _client = client;
  final http.Client _client;

  @override
  Future<Restaurant> getDetailRestaurant(String id) async {
    final response = await _client
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));
    if (response.statusCode != 200) {
      throw ServerException(message: response.body);
    }
    final decode = jsonDecode(response.body) as ResultMap;

    if (decode['error'] == true) {
      throw ServerException(message: decode['message'] as String);
    }
    return RestaurantModel.fromJson(decode['restaurant'] as ResultMap);
  }
}
