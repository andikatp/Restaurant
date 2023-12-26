import 'dart:convert';

import 'package:dicoding_final/core/constants/api_endpoint.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/data/models/detail_restaurant_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

abstract class DetailRemoteDataSource {
  const DetailRemoteDataSource();

  Future<DetailRestaurantModel> getDetailRestaurant(String id);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  DetailRemoteDataSourceImpl({required http.Client client}) : _client = client;
  final http.Client _client;

  @override
  Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
    try {
      final url =
          Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.detailRestaurant}$id');
      final response = await _client.get(url);
      if (response.statusCode != 200) {
        throw ServerException(message: response.body);
      }
      final decode = jsonDecode(response.body) as ResultMap;

      if (decode['error'] == true) {
        throw ServerException(message: decode['message'] as String);
      }
      return DetailRestaurantModel.fromJson(decode['restaurant'] as ResultMap);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString());
    }
  }
}
