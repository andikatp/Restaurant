import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/get_restaurant.dart';
import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRestaurant extends Mock implements GetRestaurants {}

void main() {
  late GetRestaurants mockUseCase;
  late RestaurantCubit restoCubit;

  setUp(() {
    mockUseCase = MockGetRestaurant();
    restoCubit = RestaurantCubit(getRestaurants: mockUseCase);
  });

  tearDown(() => restoCubit.close);

  final tRestaurantList = [const Restaurant.empty()];
  const tFailure = CacheFailure(message: 'message');

  test('Should be [RestaurantInitial] state at first', () async {
    // assert
    expect(restoCubit.state, const RestaurantInitial());
  });

  blocTest<RestaurantCubit, RestaurantState>(
    'Should emit [RestaurantLoading, RestaurantLoaded] when successful',
    build: () {
      when(() => mockUseCase()).thenAnswer((_) async => Right(tRestaurantList));
      return restoCubit;
    },
    act: (_) => restoCubit.getRestaurants(),
    expect: () => [
      const RestaurantLoading(),
      RestaurantLoaded(restaurants: tRestaurantList),
    ],
  );

  blocTest<RestaurantCubit, RestaurantState>(
    'Should emit [RestaurantLoading, RestaurantError] when unsuccessful',
    build: () {
      when(() => mockUseCase()).thenAnswer((_) async => const Left(tFailure));
      return restoCubit;
    },
    act: (_) => restoCubit.getRestaurants(),
    expect: () => [
      const RestaurantLoading(),
      RestaurantError(message: tFailure.errorMessage),
    ],
  );
}
