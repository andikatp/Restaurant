import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/restaurant/data/datasources/restaurant_local_data_source.dart';
import 'package:dicoding_final/features/restaurant/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/restaurant/data/repositories/restaurant_repo_impl.dart';
import 'package:dicoding_final/features/restaurant/domain/repositories/restaurant_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRestaurantLocalDataSource extends Mock
    implements RestaurantLocalDataSource {}

void main() {
  late RestaurantLocalDataSource mockLocalDataSource;
  late RestaurantRepo repo;

  setUp(() {
    mockLocalDataSource = MockRestaurantLocalDataSource();
    repo = RestaurantRepoImpl(dataSource: mockLocalDataSource);
  });

  final tRestaurants = [const RestaurantModel.empty()];
  const tException = CacheException(message: 'Unknown Failure');

  group('getRestaurant', () {
    test('Should call the [RestaurantLocalDataSource.getRestaurant]', () async {
      // arrange
      when(() => mockLocalDataSource.getRestaurants())
          .thenAnswer((_) async => tRestaurants);
      // act
      final result = await repo.getRestaurants();
      // assert
      expect(
        result,
        equals(Right<dynamic, List<RestaurantModel>>(tRestaurants)),
      );
      verify(() => mockLocalDataSource.getRestaurants()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test(
        'Should throw a [CacheFailure] when the call to '
        '[RestaurantLocalDataSource.getRestaurant] unsuccessful', () async {
      // arrange
      when(() => mockLocalDataSource.getRestaurants()).thenThrow(tException);
      // act
      final result = await repo.getRestaurants();
      // assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            CacheFailure.fromException(tException),
          ),
        ),
      );
      verify(() => mockLocalDataSource.getRestaurants()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('searchRestaurants', () {
    const tSearch = '';
    test('Should call the [RestaurantLocalDataSource.searchRestaurant]',
        () async {
      // arrange
      when(() => mockLocalDataSource.searchRestaurant(any()))
          .thenAnswer((_) async => tRestaurants);
      // act
      final result = await repo.searchRestaurant(tSearch);
      // assert
      expect(
        result,
        equals(Right<dynamic, List<RestaurantModel>>(tRestaurants)),
      );
      verify(() => mockLocalDataSource.searchRestaurant(tSearch)).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test(
        'Should throw a [CacheFailure] when the call to '
        '[RestaurantLocalDataSource.searchRestaurant] unsuccessful', () async {
      // arrange
      when(() => mockLocalDataSource.searchRestaurant(any()))
          .thenThrow(tException);
      // act
      final result = await repo.searchRestaurant(tSearch);
      // assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            CacheFailure.fromException(tException),
          ),
        ),
      );
      verify(() => mockLocalDataSource.searchRestaurant(tSearch)).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}
