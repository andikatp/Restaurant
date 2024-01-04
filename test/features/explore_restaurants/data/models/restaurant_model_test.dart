import 'dart:convert';

import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tRestaurant = RestaurantModel.empty();
  final tRestaurantJson =
      jsonDecode(fixtureReader('restaurant.json')) as ResultMap;

  test('Should be a subclass of [Restaurant] entity', () async {
    // assert
    expect(tRestaurant, isInstanceOf<Restaurant>());
  });

  group('toJson', () {
    test('Should convert [RestaurantModel] to Map<String, dynamic>', () async {
      // act
      final result = tRestaurant.toJson();
      final expectedMap = {
        'id': '',
        'name': '',
        'description': '',
        'pictureId': '',
        'city': '',
        'rating': 1.1,
      };
      // assert
      expect(result, equals(expectedMap));
    });
  });

  group('fromJson', () {
    test('Should convert Map<String, dynamic> to [RestaurantModel]', () async {
      // act
      final result = RestaurantModel.fromJson(tRestaurantJson);
      // assert
      expect(result, tRestaurant);
    });
  });
}
