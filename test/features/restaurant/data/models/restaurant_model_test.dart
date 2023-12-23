import 'dart:convert';

import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tRestaurant = RestaurantModel.empty();
  final tRestaurantList = [RestaurantModel.empty()];
  final tRestaurantJson = fixtureReader('restaurant.json');
  final tRestaurantListJson = (jsonDecode(tRestaurantJson) as List<dynamic>)
      .map((e) => e as Map<String, dynamic>)
      .toList();

  test('Should be a subclass of [Restaurant] entity', () async {
    // assert
    expect(tRestaurant, equals(isA<Restaurant>()));
  });

  group('fromJson', () {
    test('Should return a valid model when data is json', () async {
      // act
      final result = tRestaurantListJson.map(RestaurantModelMapper.fromMap);
      // assert
      expect(result, tRestaurantList);
    });
  });
}
