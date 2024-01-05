import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/preferences/preferences.dart';
import 'package:dicoding_final/features/notification/domain/usecases/turn_notification.dart';
import 'package:dicoding_final/features/notification/presentation/provider/scheduling_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTurnNotification extends Mock implements TurnNotification {}

class MockPreferences extends Mock implements Preferences {}

void main() {
  late SchedulingProvider schedulingProvider;
  late MockTurnNotification mockTurnNotification;
  late MockPreferences mockPreferences;

  setUp(() {
    mockTurnNotification = MockTurnNotification();
    mockPreferences = MockPreferences();
    schedulingProvider = SchedulingProvider(
      turnNotification: mockTurnNotification,
      preferences: mockPreferences,
    );
  });

  group('SchedulingProvider Tests', () {
    const tValue = true;
    const tFailure = CacheFailure(message: 'message');
    test('should schedule restaurant and update state', () async {
      // Arrange
      when(() => mockPreferences.setDailyNews(value: any(named: 'value')))
          .thenReturn(null);
      when(() => mockPreferences.isDailyRestaurantctive).thenReturn(true);
      when(() => mockTurnNotification(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      await schedulingProvider.scheduledRestaurant(value: tValue);

      // Assert
      expect(schedulingProvider.isScheduled, tValue);
      verify(() => mockPreferences.setDailyNews(value: tValue)).called(1);
      verify(() => mockPreferences.isDailyRestaurantctive).called(1);
      verify(() => mockTurnNotification(tValue)).called(1);
    });

    test('should handle failure and update error message', () async {
      // Arrange
      when(() => mockPreferences.setDailyNews(value: any(named: 'value')))
          .thenReturn(null);
      when(() => mockPreferences.isDailyRestaurantctive).thenReturn(false);
      when(() => mockTurnNotification(any()))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      await schedulingProvider.scheduledRestaurant(value: true);

      // Assert
      expect(schedulingProvider.isScheduled, false);
      expect(schedulingProvider.errorMessage, tFailure.errorMessage);
      verify(() => mockPreferences.setDailyNews(value: true)).called(1);
      verify(() => mockPreferences.isDailyRestaurantctive).called(1);
      verify(() => mockTurnNotification(true)).called(1);
    });
  });
}
