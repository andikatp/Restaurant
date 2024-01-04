import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/get_restaurants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantRepo extends Mock implements ExploreRestaurantsRepo {}

void main() {
  late ExploreRestaurantsRepo mockRepository;
  late GetRestaurants usecase;

  setUp(() {
    mockRepository = MockRestaurantRepo();
    usecase = GetRestaurants(repo: mockRepository);
  });

  final tListRestaurants = [const Restaurant.empty(), const Restaurant.empty()];
  const tFailure = ServerFailure(message: 'message');

  test('Should call [RestaurantRepo] when call [GetRestaurant] usecase',
      () async {
    // arrange
    when(() => mockRepository.getRestaurants())
        .thenAnswer((_) async => Right(tListRestaurants));
    // act
    final result = await usecase();
    // assert
    expect(result, equals(Right<dynamic, List<Restaurant>>(tListRestaurants)));
    verify(() => mockRepository.getRestaurants()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('Should return [CacheFailure] when call [GetRestaurant] usecase failed',
      () async {
    // arrange
    when(() => mockRepository.getRestaurants())
        .thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecase();
    // assert
    expect(result, equals(const Left<Failure, dynamic>(tFailure)));
    verify(() => mockRepository.getRestaurants()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
