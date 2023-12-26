import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  late NetworkInfo networkInfo;
  late InternetConnection mockInternetConnection;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(networkInfo: mockInternetConnection);
  });

  test('Should forward the call to ConnectionChecker.hasInternetAccess',
      () async {
    // arrange
    final tHasConnection = Future.value(true);
    when(() => mockInternetConnection.hasInternetAccess)
        .thenAnswer((_) => tHasConnection);
    // act
    final result = networkInfo.isConnected;
    // assert
    verify(() => mockInternetConnection.hasInternetAccess);
    expect(result, tHasConnection);
  });
}
