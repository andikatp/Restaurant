import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/search_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRepo extends Mock implements ExploreRestaurantsRepo {}

void main() {
  late ExploreRestaurantsRepo mockRepo;
  late SearchRestaurant usecase;

  setUp(() {
    mockRepo = MockSearchRepo();
    usecase = SearchRestaurant(repo: mockRepo);
  });

  const tRestaurants = [Restaurant.empty()];
  const tRestaurantName = 'test';
  const tFailure = ServerFailure(message: 'message');

  test('Should call [SearchRepo] when call [SearchRestaurant] usecase',
      () async {
    // arrange
    when(() => mockRepo.searchRestaurants(any()))
        .thenAnswer((_) async => const Right(tRestaurants));
    // act
    final result = await usecase(tRestaurantName);
    // assert
    expect(
      result,
      equals(const Right<dynamic, List<Restaurant>>(tRestaurants)),
    );
    verify(() => mockRepo.searchRestaurants(tRestaurantName)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  test(
      'Should  return [ServerFailure] when call [GetRestaurant] usecase failed',
      () async {
    // arrange
    when(() => mockRepo.searchRestaurants(any()))
        .thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecase(tRestaurantName);
    // assert
    expect(result, const Left<Failure, dynamic>(tFailure));
  });
}
