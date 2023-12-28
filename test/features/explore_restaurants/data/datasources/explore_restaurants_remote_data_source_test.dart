import 'package:dicoding_final/core/constants/api_endpoint.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/remote/explore_restaurants_remote_data_source.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ExploreRestaurantsRemoteDataSource remote;
  late http.Client mockClient;

  setUp(() {
    mockClient = MockHttpClient();
    remote = ExploreRestaurantsRemoteDataSourceImpl(client: mockClient);
    registerFallbackValue(Uri());
  });

  const tRestaurantName = 'test';
  const tRestaurants = [RestaurantModel.empty()];

  group('getRestaurants', () {
    test('Should perform a GET request on an URL', () async {
      // arrange
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(fixtureReader('list_restaurant.json'), 200),
      );
      // act
      await remote.getRestaurants();
      // assert
      verify(
        () => mockClient.get(
          Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.allRestaurants}'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('Should return List of [Restaurant] when the response is 200',
        () async {
      // arrange
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(fixtureReader('list_restaurant.json'), 200),
      );
      // act
      final result = await remote.getRestaurants();
      // assert
      expect(result, tRestaurants);
    });

    test('Should throw a server exception when the response code is not 200',
        () async {
      // arrange
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response('Something went wrong', 400),
      );
      // act
      final result = remote.getRestaurants;
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('searchRestaurants', () {
    test('Should perform a GET request on an URL', () async {
      // arrange
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(fixtureReader('list_restaurant.json'), 200),
      );
      // act
      await remote.searchRestaurant(tRestaurantName);
      // assert
      final url = Uri.parse(
        '${AppConstant.baseUrl}${ApiEndpoint.searchRestaurants}'
        '$tRestaurantName',
      );
      verify(
        () => mockClient.get(url),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('Should return List of [Restaurant] when the response is 200',
        () async {
      // arrange
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(fixtureReader('list_restaurant.json'), 200),
      );
      // act
      final result = await remote.searchRestaurant(tRestaurantName);
      // assert
      expect(result, tRestaurants);
    });

    test('Should throw a server exception when the response code is not 200',
        () async {
      // arrange
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response('Something went wrong', 400),
      );
      // act
      final result = remote.searchRestaurant(tRestaurantName);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
