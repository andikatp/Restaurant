import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/settings/domain/repositories/notification_repo.dart';
import 'package:dicoding_final/features/settings/domain/usecases/turn_notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepo extends Mock implements NotificationRepo {}

void main() {
  late NotificationRepo mockNotificationRepo;
  late TurnNotification usecases;

  setUp(() {
    mockNotificationRepo = MockNotificationRepo();
    usecases = TurnNotification(repo: mockNotificationRepo);
  });

  const tValue = true;
  const tFailure = CacheFailure(message: 'message');

  test('Should call [NotificationRepo] when call [TurnNotification] usecase',
      () async {
    // arrange
    when(
      () => mockNotificationRepo.turnNotification(value: any(named: 'value')),
    ).thenAnswer((_) async => const Right(null));
    // act
    final result = await usecases(tValue);
    // assert
    expect(result, const Right<dynamic, void>(null));
    verify(() => mockNotificationRepo.turnNotification(value: tValue));
    verifyNoMoreInteractions(mockNotificationRepo);
  });

  test(
      'Should return [ServerFailure] when call [TurnNotification] '
      'usecase failed', () async {
    // arrange
    when(
      () => mockNotificationRepo.turnNotification(value: any(named: 'value')),
    ).thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecases(true);
    // assert
    expect(result, const Left<Failure, dynamic>(tFailure));
    verify(() => mockNotificationRepo.turnNotification(value: tValue));
    verifyNoMoreInteractions(mockNotificationRepo);
  });
}
