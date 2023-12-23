import 'dart:convert';

import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tRestaurant = RestaurantModel.empty();
  final tRestaurantJson =
      jsonDecode(fixtureReader('restaurant.json')) as Map<String, dynamic>;

  test('Should be a subclass of [Restaurant] entity', () async {
    // assert
    expect(tRestaurant, equals(isA<Restaurant>()));
  });

  group('fromJson', () {
    test('Should return a valid model when data is json', () async {
      // act
      final result = RestaurantModel.fromJson(tRestaurantJson);
      // assert
      expect(result, tRestaurant);
    });
  });

  group('toJson', () {
    test('Should convert [RestaurantModel] to Map<String, dynamic>', () {
      // act
      final result = tRestaurant.toJson();
      //assert
      final expectedMap = {
        'id': '',
        'name': '',
        'description': '',
        'pictureId': '',
        'city': '',
        'rating': 1.1,
        'menus': {
          'foods': [
            {'name': ''},
          ],
          'drinks': [
            {'name': ''},
          ],
        },
      };
      expect(result, equals(expectedMap));
    });
  });
}
