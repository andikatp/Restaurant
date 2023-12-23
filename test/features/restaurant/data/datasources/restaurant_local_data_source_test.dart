import 'dart:convert';

import 'package:dicoding_final/features/restaurant/data/datasources/restaurant_local_data_source.dart';
import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  late RestaurantLocalDataSource localData;

  setUp(() => localData = RestaurantLocalDataSourceImpl());

  final tRestaurantJson = jsonDecode(fixtureReader('list_restaurant.json'));
  final tRestaurantList = [const RestaurantModel.empty()];

  test('Should return List of Restaurant when [localData] being called',
      () async {
    // act
    // final result = (tRestaurantJson as List<dynamic>)
    //     .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>));
    final result2 = await localData.getRestaurants();
    print(result2);
    // assert
    // expect(result, tRestaurantList);
  });
}
