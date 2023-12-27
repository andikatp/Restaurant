import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/features/detail/data/datasources/detail_remote_data_source.dart';
import 'package:dicoding_final/features/detail/data/models/detail_restaurant_model.dart';
import 'package:dicoding_final/features/detail/data/repositories/detail_repo_impl.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';
import 'package:dicoding_final/features/detail/domain/usecases/review_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailRemoteDataSource extends Mock
    implements DetailRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late DetailRepo repo;
  late DetailRemoteDataSource mockRemote;
  late NetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemote = MockDetailRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = DetailRepoImpl(remote: mockRemote, network: mockNetworkInfo);
  });

  const tId = '1';
  const tRestaurant = DetailRestaurantModel.empty();

  test('Should check if the device is online', () async {
    // arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(() => mockRemote.getDetailRestaurant(any()))
        .thenAnswer((_) async => tRestaurant);
    // act
    await repo.getDetailRestaurant(tId);
    // assert
    expect(true, await mockNetworkInfo.isConnected);
  });

  group('device is online', () {
    const tException = ServerException(message: 'message');

    setUp(
      () =>
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true),
    );

    group('GetDetail', () {
      test(
          'Should return remote data when the call to '
          'remote data is successful', () async {
        // arrange
        when(() => mockRemote.getDetailRestaurant(any()))
            .thenAnswer((_) async => tRestaurant);
        // act
        final result = await repo.getDetailRestaurant(tId);
        // assert
        expect(
          result,
          equals(const Right<dynamic, DetailRestaurantModel>(tRestaurant)),
        );
        verify(() => mockRemote.getDetailRestaurant(tId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      test(
          'Should return server failure data when the call to '
          'remote data is unsuccessful', () async {
        // arrange
        when(() => mockRemote.getDetailRestaurant(any())).thenThrow(tException);
        // act
        final result = await repo.getDetailRestaurant(tId);
        // assert
        expect(
          result,
          equals(
            Left<Failure, dynamic>(ServerFailure.fromException(tException)),
          ),
        );
        verify(() => mockRemote.getDetailRestaurant(tId)).called(1);
        verifyNoMoreInteractions(mockRemote);
      });

      group('addReview', () {
        const tParams = ReviewParams(id: 'id', review: 'review');
        test(
            'Should return remote data when the call to '
            'remote data is successful', () async {
          // arrange
          when(() => mockRemote.reviewRestaurant(any(), any()))
              .thenAnswer((_) async => Future.value());
          // act
          final result =
              await repo.reviewRestaurant(tParams.id, tParams.review);
          // assert
          expect(
            result,
            equals(const Right<dynamic, void>(null)),
          );
          verify(() => mockRemote.getDetailRestaurant(tId)).called(1);
          verifyNoMoreInteractions(mockRemote);
        });

        test(
            'Should return server failure data when the call to '
            'remote data is unsuccessful', () async {
          // arrange
          when(() => mockRemote.reviewRestaurant(any(), any()))
              .thenThrow(tException);
          // act
          final result =
              await repo.reviewRestaurant(tParams.id, tParams.review);
          // assert
          expect(
            result,
            equals(
              Left<Failure, dynamic>(ServerFailure.fromException(tException)),
            ),
          );
          verify(() => mockRemote.reviewRestaurant(tParams.id, tParams.review))
              .called(1);
          verifyNoMoreInteractions(mockRemote);
        });
      });
    });
  });
}
