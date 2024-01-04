import 'package:dicoding_final/features/explore_restaurants/data/datasources/local/DAO/restaurant_dao.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantDao extends Mock implements RestaurantDao {}

void main() {
  late MockRestaurantDao mockDao;
  late RestaurantModel tRestaurant;

  setUp(() {
    mockDao = MockRestaurantDao();
    tRestaurant = const RestaurantModel.empty();
  });

  final tExpectedRestaurants = [const RestaurantModel.empty()];

  test('Should get a list of restaurants', () async {
    // arrange
    when(() => mockDao.getRestaurants())
        .thenAnswer((_) async => tExpectedRestaurants);

    // act
    final result = await mockDao.getRestaurants();

    // assert
    verify(() => mockDao.getRestaurants()).called(1);
    expect(result, equals(tExpectedRestaurants));
  });

  test('Should save a restaurant', () async {
    // arrange
    when(() => mockDao.saveRestaurant(tRestaurant)).thenAnswer((_) async {});

    // act
    await mockDao.saveRestaurant(tRestaurant);

    // assert
    verify(() => mockDao.saveRestaurant(tRestaurant)).called(1);
  });

  test('Should delete a saved restaurant', () async {
    // arrange
    when(() => mockDao.deleteSavedRestaurant(tRestaurant))
        .thenAnswer((_) async {});

    // act
    await mockDao.deleteSavedRestaurant(tRestaurant);

    // assert
    verify(() => mockDao.deleteSavedRestaurant(tRestaurant)).called(1);
  });
}
