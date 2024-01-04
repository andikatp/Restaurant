import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/save_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRestaurantsRepo extends Mock
    implements ExploreRestaurantsRepo {}

void main() {
  late ExploreRestaurantsRepo mockRepo;
  late SaveRestaurant usecase;

  setUp(() {
    mockRepo = MockExploreRestaurantsRepo();
    usecase = SaveRestaurant(repo: mockRepo);
    registerFallbackValue(const Restaurant.empty());
  });

  const tRestaurants = Restaurant.empty();
  const tFailure = ServerFailure(message: 'message');

  test(
      'Should call [ExploreRestaurantsRepo] and return void when call '
      '[SaveRestaurant] usecase', () async {
    // arrange
    when(() => mockRepo.saveRestaurant(any()))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(tRestaurants);
    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => mockRepo.saveRestaurant(tRestaurants)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  test(
      'Should  return [ServerFailure] when call [SaveRestaurant] '
      'usecase failed ', () async {
    // arrange
    when(() => mockRepo.saveRestaurant(any()))
        .thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecase(tRestaurants);
    // assert
    expect(result, equals(const Left<Failure, dynamic>(tFailure)));
    verify(() => mockRepo.saveRestaurant(tRestaurants)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
