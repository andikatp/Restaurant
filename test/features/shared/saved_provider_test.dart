import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/delete_saved_restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/get_saved_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/save_restaurant.dart';
import 'package:dicoding_final/features/shared/saved_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveRestaurant extends Mock implements SaveRestaurant {}

class MockGetSavedRestaurants extends Mock implements GetSavedRestaurants {}

class MockDeleteSavedRestaurant extends Mock implements DeleteSavedRestaurant {}

void main() {
  late SavedProvider savedProvider;
  late MockSaveRestaurant mockSaveRestaurant;
  late MockGetSavedRestaurants mockGetSavedRestaurants;
  late MockDeleteSavedRestaurant mockDeleteSavedRestaurant;

  setUp(() {
    mockSaveRestaurant = MockSaveRestaurant();
    mockGetSavedRestaurants = MockGetSavedRestaurants();
    mockDeleteSavedRestaurant = MockDeleteSavedRestaurant();

    savedProvider = SavedProvider(
      saveRestaurant: mockSaveRestaurant,
      getSavedRestaurants: mockGetSavedRestaurants,
      deleteSavedRestaurant: mockDeleteSavedRestaurant,
    );

    registerFallbackValue(const Restaurant.empty());
  });

  group('SavedProviderTests', () {
    const tRestaurant = Restaurant.empty();
    const tRestaurantsList = [Restaurant.empty()];
    const tFailure = CacheFailure(message: 'message');

    group('saveAndGetRestaurants', () {
      test('should save restaurant and update state', () async {
        // Arrange
        when(() => mockSaveRestaurant(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => mockGetSavedRestaurants())
            .thenAnswer((_) async => const Right(tRestaurantsList));

        // Act
        await savedProvider.saveRestaurant(tRestaurant);
        await savedProvider.getSavedRestaurant();

        // Assert
        expect(savedProvider.restaurants.length, 1);
        verify(() => mockSaveRestaurant(tRestaurant)).called(1);
        verify(() => mockGetSavedRestaurants()).called(1);
      });

      test('Should handle failure when saving restaurant', () async {
        // Arrange
        when(() => mockSaveRestaurant(any()))
            .thenAnswer((_) async => const Left(tFailure));

        // Act
        await savedProvider.saveRestaurant(tRestaurant);

        // Assert
        expect(savedProvider.messageOfError, AppConstant.cacheFailureMessage);
        verify(() => mockSaveRestaurant(tRestaurant)).called(1);
      });
    });

    group('deleteRestaurant', () {
      test('should delete restaurant', () async {
        // Arrange
        when(() => mockDeleteSavedRestaurant(any()))
            .thenAnswer((_) async => const Right(null));

        // Act
        await savedProvider.deleteSavedRestaurant(tRestaurant);

        // Assert
        verify(() => mockDeleteSavedRestaurant(tRestaurant)).called(1);
        verifyNoMoreInteractions(mockDeleteSavedRestaurant);
      });

      test('Should handle failure when delete restaurant failed', () async {
        // Arrange
        when(() => mockDeleteSavedRestaurant(any()))
            .thenAnswer((_) async => const Left(tFailure));

        // Act
        await savedProvider.deleteSavedRestaurant(tRestaurant);

        // Assert
        expect(savedProvider.messageOfError, AppConstant.cacheFailureMessage);
        verify(() => mockDeleteSavedRestaurant(tRestaurant)).called(1);
        verifyNoMoreInteractions(mockDeleteSavedRestaurant);
      });
    });
  });
}
