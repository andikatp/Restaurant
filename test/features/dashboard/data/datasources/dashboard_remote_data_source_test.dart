import 'package:dicoding_final/core/constants/api_endpoint.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:dicoding_final/shared/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client mockClient;
  late DashboardRemoteDataSource remote;

  setUp(() {
    mockClient = MockHttpClient();
    remote = DashboardRemoteDataSourceImpl(client: mockClient);
    registerFallbackValue(Uri());
  });

  const tListRestaurants = <RestaurantModel>[
    RestaurantModel.empty(),
  ];

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

  test('Should return List of [Restaurant] when the response is 200', () async {
    // arrange
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response(fixtureReader('list_restaurant.json'), 200),
    );
    // act
    final result = await remote.getRestaurants();
    // assert
    expect(result, tListRestaurants);
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
}
