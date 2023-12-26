import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:dicoding_final/features/dashboard/data/repositories/dashboard_repo_impl.dart';
import 'package:dicoding_final/features/dashboard/domain/repositories/dashboard_repo.dart';
import 'package:dicoding_final/shared/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDashboardRemoteDatasource extends Mock
    implements DashboardRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late DashboardRemoteDataSource mockRemote;
  late NetworkInfo mockNetworkInfo;
  late DashboardRepoImpl repo;

  setUp(() {
    mockRemote = MockDashboardRemoteDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repo =
        DashboardRepoImpl(networkInfo: mockNetworkInfo, dataSource: mockRemote);
  });

  test('Should check if the device is online', () async {
    // arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockRemote.getRestaurants)
        .thenAnswer((_) async => <RestaurantModel>[]);
    // act
    await repo.getRestaurants();
    // assert
    expect(true, await mockNetworkInfo.isConnected);
  });

  group('device is online', () {
    const tListRestaurants = <RestaurantModel>[
      RestaurantModel.empty(),
      RestaurantModel.empty(),
    ];
    const tException = ServerException(message: 'message');

    setUp(
      () =>
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true),
    );

    test('Should return remote data when the call to remote data is successful',
        () async {
      // arrange
      when(() => mockRemote.getRestaurants())
          .thenAnswer((_) async => tListRestaurants);
      // act
      final result = await repo.getRestaurants();
      // assert
      expect(
        result,
        equals(const Right<dynamic, List<RestaurantModel>>(tListRestaurants)),
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
