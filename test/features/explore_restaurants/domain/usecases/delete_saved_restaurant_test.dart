import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/delete_saved_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRestaurantsRepo extends Mock
    implements ExploreRestaurantsRepo {}

void main() {
  late ExploreRestaurantsRepo mockRepo;
  late DeleteSavedRestaurant usecase;

  setUp(() {
    mockRepo = MockExploreRestaurantsRepo();
    usecase = DeleteSavedRestaurant(repo: mockRepo);
    registerFallbackValue(const Restaurant.empty());
  });

  const tRestaurants = Restaurant.empty();
  const tFailure = ServerFailure(message: 'message');

  test(
      'Should call [ExploreRestaurantsRepo] and return void when call '
      '[DeleteSavedRestaurant] usecase', () async {
    // arrange
    when(() => mockRepo.deleteSavedRestaurant(any()))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(tRestaurants);
    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => mockRepo.deleteSavedRestaurant(tRestaurants)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  test(
      'Should  return [ServerFailure] when call [DeleteSavedRestaurant] '
      'usecase failed ', () async {
    // arrange
    when(() => mockRepo.deleteSavedRestaurant(any()))
        .thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecase(tRestaurants);
    // assert
    expect(result, equals(const Left<Failure, dynamic>(tFailure)));
    verify(() => mockRepo.deleteSavedRestaurant(tRestaurants)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
