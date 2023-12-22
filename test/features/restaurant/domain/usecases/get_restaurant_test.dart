import 'package:dartz/dartz.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/repositories/restaurant_repo.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/get_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantRepo extends Mock implements RestaurantRepo {}

void main() {
  late RestaurantRepo mockRepository;
  late GetRestaurants usecase;

  setUp(() {
    mockRepository = MockRestaurantRepo();
    usecase = GetRestaurants(repo: mockRepository);
  });

  final tListRestaurants = [Restaurant.empty(), Restaurant.empty()];

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
}
