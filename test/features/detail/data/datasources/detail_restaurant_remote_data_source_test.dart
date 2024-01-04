import 'dart:convert';

import 'package:dicoding_final/core/constants/api_endpoint.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/features/detail/data/datasources/remote/detail_remote_data_source.dart';
import 'package:dicoding_final/features/detail/data/models/detail_restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client mockClient;
  late DetailRemoteDataSource remote;

  setUp(() {
    mockClient = MockHttpClient();
    remote = DetailRemoteDataSourceImpl(client: mockClient);
    registerFallbackValue(Uri());
  });
  tearDown(() {});

  const tRestaurant = DetailRestaurantModel.empty();
  const tId = '1';

  group('getDetailRestaurant', () {
    test('Should perform a GET request on an URL', () async {
      // arrange
      when(() => mockClient.get(any(that: isA<Uri>()))).thenAnswer(
        (_) async =>
            http.Response(fixtureReader('detail_restaurant.json'), 200),
      );
      // act
      await remote.getDetailRestaurant(tId);
      // assert
      verify(
        () => mockClient.get(
          Uri.parse(
            '${AppConstant.baseUrl}${ApiEndpoint.detailRestaurant}/$tId',
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('Should return List of [Restaurant] when the response is 200',
        () async {
      // arrange
      when(() => mockClient.get(any(that: isA<Uri>()))).thenAnswer(
        (_) async =>
            http.Response(fixtureReader('detail_restaurant.json'), 200),
      );
      // act
      final result = await remote.getDetailRestaurant(tId);
      // assert
      expect(result, tRestaurant);
    });

    test('Should throw a server exception when the response code is not 200',
        () async {
      // arrange
      when(() => mockClient.get(any(that: isA<Uri>()))).thenAnswer(
        (_) async => http.Response(
          '{"error": true, "message": "Something went wrong"}',
          400,
        ),
      );
      // act
      final result = remote.getDetailRestaurant(tId);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('reviewRestaurant', () {
    const tId = 'id';
    const tReview = 'review';

    test(
        'Should perform a POST request on an URL '
        'when the status code is 201', () async {
      // arrange
      when(
        () => mockClient.post(
          any(that: isA<Uri>()),
          body: any(named: 'body'),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"error": false, "message": "Review has been added successfully"}',
          201,
        ),
      );
      // act and assert
      await expectLater(remote.reviewRestaurant(tId, tReview), completes);
      // assert
      verify(
        () => mockClient.post(
          Uri.parse(
            '${AppConstant.baseUrl}${ApiEndpoint.postReview}',
          ),
          body: jsonEncode(
            {'id': tId, 'name': 'New User', 'review': tReview},
          ),
          headers: {'Content-Type': 'application/json'},
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('Should throw a server exception when the response code is not 201',
        () async {
      // arrange
      when(
        () => mockClient.post(
          any(that: isA<Uri>()),
          body: any(named: 'body'),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"error": true, "message": "Something went wrong"}',
          400,
        ),
      );
      // act
      final methodCall = remote.reviewRestaurant;
      // assert
      expect(
        methodCall(tId, tReview),
        throwsA(const ServerException(message: 'Something went wrong')),
      );
    });
  });
}
