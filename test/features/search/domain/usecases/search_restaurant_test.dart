import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/search/domain/repositories/search_repo.dart';
import 'package:dicoding_final/features/search/domain/usecases/search_restaurant.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRepo extends Mock implements SearchRepo {}

void main() {
  late SearchRepo mockRepo;
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
    when(() => mockRepo.searchRestaurant(any()))
        .thenAnswer((_) async => const Right(tRestaurants));
    // act
    final result = await usecase(tRestaurantName);
    // assert
    expect(
      result,
      equals(const Right<dynamic, List<Restaurant>>(tRestaurants)),
    );
    verify(() => mockRepo.searchRestaurant(tRestaurantName)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  test(
      'Should  return [ServerFailure] when call [GetRestaurant] usecase failed',
      () async {
    // arrange
    when(() => mockRepo.searchRestaurant(any()))
        .thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecase(tRestaurantName);
    // assert
    expect(result, const Left<Failure, dynamic>(tFailure));
  });
}
