import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/local/app_database.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/remote/explore_restaurants_remote_data_source.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/explore_restaurants/data/repositories/explore_restaurants_impl.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExploreRestaurantsRemoteDataSource extends Mock
    implements ExploreRestaurantsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockDatabase extends Mock implements AppDatabase {}

void main() {
  late ExploreRestaurantsRemoteDataSource mockRemote;
  late NetworkInfo mockNetworkInfo;
  late ExploreRestaurantsRepo repo;
  late AppDatabase mockDatabase;

  setUp(() {
    mockRemote = MockExploreRestaurantsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockDatabase = MockDatabase();
    repo = ExploreRestaurantsRepoImpl(
      dataSource: mockRemote,
      networkInfo: mockNetworkInfo,
      database: mockDatabase,
    );
  });

  const tRestaurantName = 'test';
  const tRestaurants = [RestaurantModel.empty()];

  test('Should check if the device is online', () async {
    // arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(() => mockRemote.searchRestaurant(any()))
        .thenAnswer((_) async => tRestaurants);
    // act
    await repo.searchRestaurants(tRestaurantName);
    // assert
    expect(true, await mockNetworkInfo.isConnected);
  });

  group('deviceIsOnline', () {
    const tException = ServerException(message: 'message');

    setUp(
      () =>
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true),
    );

    test('Should return remote data when the call to remote data is successful',
        () async {
      // arrange
      when(() => mockRemote.searchRestaurant(any()))
          .thenAnswer((_) async => tRestaurants);
      // act
      final result = await repo.searchRestaurants(tRestaurantName);
      // assert
      expect(
        result,
        equals(const Right<dynamic, List<RestaurantModel>>(tRestaurants)),
      );
      verify(() => mockRemote.searchRestaurant(tRestaurantName)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test(
        'Should return server failure data when the call to '
        'remote data is unsuccessful', () async {
      // arrange
      when(() => mockRemote.searchRestaurant(any())).thenThrow(tException);
      // act
      final result = await repo.searchRestaurants(tRestaurantName);
      // assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        ),
      );
      verify(() => mockRemote.searchRestaurant(tRestaurantName)).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('Should return remote data when the call to remote data is successful',
        () async {
      // arrange
      when(() => mockRemote.getRestaurants())
          .thenAnswer((_) async => tRestaurants);
      // act
      final result = await repo.getRestaurants();
      // assert
      expect(
        result,
        equals(const Right<dynamic, List<RestaurantModel>>(tRestaurants)),
      );
      verify(() => mockRemote.getRestaurants()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test(
        'Should return server failure data when the call to '
        'remote data is unsuccessful', () async {
      // arrange
      when(() => mockRemote.getRestaurants()).thenThrow(tException);
      // act
      final result = await repo.getRestaurants();
      // assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        ),
      );
      verify(() => mockRemote.getRestaurants()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}
