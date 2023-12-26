import 'package:dicoding_final/core/constants/api_endpoint.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/features/detail/data/datasources/detail_remote_data_source.dart';
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

  const tRestaurant = DetailRestaurantModel.empty();
  const tId = '1';

  test('Should perform a GET request on an URL', () async {
    // arrange
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response(fixtureReader('restaurant.json'), 200),
    );
    // act
    await remote.getDetailRestaurant(tId);
    // assert
    verify(
      () => mockClient.get(
        Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.detailRestaurant}/$tId'),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockClient);
  });

  test('Should return List of [Restaurant] when the response is 200', () async {
    // arrange
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response(fixtureReader('restaurant.json'), 200),
    );
    // act
    final result = await remote.getDetailRestaurant(tId);
    // assert
    expect(result, tRestaurant);
  });

  test('Should throw a server exception when the response code is not 200',
      () async {
    // arrange
    when(() => mockClient.get(any())).thenAnswer(
      (_) async => http.Response('Something went wrong', 400),
    );
    // act
    final result = remote.getDetailRestaurant(tId);
    // assert
    expect(result, throwsA(isA<ServerException>()));
  });
}
