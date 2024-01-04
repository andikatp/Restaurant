import 'dart:convert';
import 'package:dicoding_final/core/constants/api_endpoint.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/data/models/detail_restaurant_model.dart';
import 'package:http/http.dart' as http;

abstract class DetailRemoteDataSource {
  const DetailRemoteDataSource();

  /// Calls the https://restaurant-api.dicoding.dev/detail/:id endpoint.
  ///
  /// Throw a [ServerException] for all the error codes.
  Future<DetailRestaurantModel> getDetailRestaurant(String id);

  /// Calls the https://restaurant-api.dicoding.dev/review post endpoint.
  ///
  /// Throw a [ServerException] for all the error codes.
  Future<void> reviewRestaurant(String id, String review);
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  DetailRemoteDataSourceImpl({required http.Client client}) : _client = client;
  final http.Client _client;

  @override
  Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
    final url = Uri.parse(
      '${AppConstant.baseUrl}${ApiEndpoint.detailRestaurant}/$id',
    );
    final response = await _client.get(url);

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }

    if (decode['error'] == true) {
      throw ServerException(message: decode['message'] as String);
    }

    return DetailRestaurantModel.fromJson(decode['restaurant'] as ResultMap);
  }

  @override
  Future<void> reviewRestaurant(String id, String review) async {
    final url = Uri.parse(AppConstant.baseUrl + ApiEndpoint.postReview);
    final response = await _client.post(
      url,
      body: jsonEncode({'id': id, 'name': 'New User', 'review': review}),
      headers: {'Content-Type': 'application/json'},
    );

    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpPostStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }

    if (decode['error'] == true) {
      throw ServerException(message: decode['message'] as String);
    }
  }
}
