import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/get_saved_restaurants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRestaurantsRepo extends Mock
    implements ExploreRestaurantsRepo {}

void main() {
  late ExploreRestaurantsRepo mockRepo;
  late GetSavedRestaurants usecase;

  setUp(() {
    mockRepo = MockExploreRestaurantsRepo();
    usecase = GetSavedRestaurants(repo: mockRepo);
  });

  final tRestaurantsList = [const Restaurant.empty()];
  const tFailure = ServerFailure(message: 'message');

  test(
      'Should call [ExploreRestaurantsRepo] and return void when call '
      '[GetSavedRestaurants] usecase', () async {
    // arrange
    when(() => mockRepo.getSavedRestaurants())
        .thenAnswer((_) async => Right(tRestaurantsList));
    // act
    final result = await usecase();
    // assert
    expect(result, equals(Right<dynamic, List<Restaurant>>(tRestaurantsList)));
    verify(() => mockRepo.getSavedRestaurants()).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  test(
      'Should  return [ServerFailure] when call [GetSavedRestaurants] '
      'usecase failed ', () async {
    // arrange
    when(() => mockRepo.getSavedRestaurants())
        .thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecase();
    // assert
    expect(result, equals(const Left<Failure, dynamic>(tFailure)));
    verify(() => mockRepo.getSavedRestaurants()).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
