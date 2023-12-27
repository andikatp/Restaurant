import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/features/detail/data/models/detail_restaurant_model.dart';
import 'package:dicoding_final/features/search/data/datasources/search_remote_data_source.dart';
import 'package:dicoding_final/features/search/data/repositories/search_repo_impl.dart';
import 'package:dicoding_final/features/search/domain/repositories/search_repo.dart';
import 'package:dicoding_final/shared/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRemoteDataSource extends Mock
    implements SearchRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late SearchRemoteDataSource mockRemote;
  late NetworkInfo mockNetworkInfo;
  late SearchRepo repo;

  setUp(() {
    mockRemote = MockSearchRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = SearchRepoImpl(dataSource: mockRemote, networkInfo: mockNetworkInfo);
  });

  const tRestaurantName = 'test';
  const tRestaurants = [RestaurantModel.empty()];

  test('Should check if the device is online', () async {
    // arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(() => mockRemote.searchRestaurant(any()))
        .thenAnswer((_) async => tRestaurants);
    // act
    await repo.searchRestaurant(tRestaurantName);
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
      final result = await repo.searchRestaurant(tRestaurantName);
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
      final result = await repo.searchRestaurant(tRestaurantName);
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
  });
}
