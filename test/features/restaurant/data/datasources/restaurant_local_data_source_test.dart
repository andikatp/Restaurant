import 'package:dicoding_final/features/restaurant/data/datasources/restaurant_local_data_source.dart';
import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  late RestaurantLocalDataSource localData;

  setUp(() => localData = RestaurantLocalDataSourceImpl());

  test('Should return List of Restaurant when [localData] being called',
      () async {
    // act
    final result = await localData.getRestaurants();
    // assert
    expect(result, isA<List<RestaurantModel>>());
  });
}
