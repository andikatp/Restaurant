import 'package:dicoding_final/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client mockClient;
  late DashboardRemoteDataSource remote;

  setUp(() {
    mockClient = MockHttpClient();
    remote = DashboardRemoteDataSourceImpl(client: http.Client());
  });

  test(
    'Should ',
    () async {
      // arrange
      // when(() => mockClient.get(any())).thenAnswer((_) => );
      // act
      final result = await remote.getRestaurant();
      // assert
    }
  );
}
