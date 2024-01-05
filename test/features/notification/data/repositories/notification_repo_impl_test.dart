import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/notification/data/datasources/notification_data_source.dart';
import 'package:dicoding_final/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:dicoding_final/features/notification/domain/repositories/notification_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationDataSource extends Mock
    implements NotificationDataSource {}

void main() {
  late NotificationDataSource mockDataSource;
  late NotificationRepo notificationRepo;

  setUp(() {
    mockDataSource = MockNotificationDataSource();
    notificationRepo = NotificationRepoImpl(dataSource: mockDataSource);
  });

  const tValue = true;
  const tException = CacheException(message: 'message');

  test(
      'Should return remote data when the call to '
      'remote data is successful', () async {
    // arrange
    when(
      () => mockDataSource.showNotification(
        isScheduled: any(named: 'isScheduled'),
      ),
    ).thenAnswer((_) async => true);
    // act
    final result = await notificationRepo.turnNotification(value: tValue);
    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => mockDataSource.showNotification(isScheduled: tValue));
    verifyNoMoreInteractions(mockDataSource);
  });

  test(
      'Should return [CacheFailure] data when the call to '
      'remote data is unsuccessful', () async {
    // arrange
    when(
      () => mockDataSource.showNotification(
        isScheduled: any(named: 'isScheduled'),
      ),
    ).thenThrow(tException);
    // act
    final result = await notificationRepo.turnNotification(value: tValue);
    // assert
    expect(
      result,
      equals(Left<Failure, dynamic>(CacheFailure.fromException(tException))),
    );
    verify(() => mockDataSource.showNotification(isScheduled: tValue));
    verifyNoMoreInteractions(mockDataSource);
  });
}
