import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/get_restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/search_restaurant.dart';
import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRestaurant extends Mock implements GetRestaurants {}

class MockSearchRestaurant extends Mock implements SearchRestaurant {}

void main() {
  late GetRestaurants mockGetUseCase;
  late SearchRestaurant mockSearchUseCase;
  late RestaurantCubit restoCubit;

  setUp(() {
    mockGetUseCase = MockGetRestaurant();
    mockSearchUseCase = MockSearchRestaurant();
    restoCubit = RestaurantCubit(
      getRestaurants: mockGetUseCase,
      searchRestaurant: mockSearchUseCase,
    );
  });

  tearDown(() => restoCubit.close);

  final tRestaurantList = [const Restaurant.empty()];
  const tFailure = CacheFailure(message: 'message');

  test('Should be [RestaurantInitial] state at first', () async {
    // assert
    expect(restoCubit.state, const RestaurantInitial());
  });

  group('getRestaurants', () {
    blocTest<RestaurantCubit, RestaurantState>(
      'Should emit [RestaurantLoading, RestaurantLoaded] when successful',
      build: () {
        when(() => mockGetUseCase())
            .thenAnswer((_) async => Right(tRestaurantList));
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
        when(() => mockGetUseCase())
            .thenAnswer((_) async => const Left(tFailure));
        return restoCubit;
      },
      act: (_) => restoCubit.getRestaurants(),
      expect: () => [
        const RestaurantLoading(),
        RestaurantError(message: tFailure.errorMessage),
      ],
    );
  });

  group('searchRestaurants', () {
    blocTest<RestaurantCubit, RestaurantState>(
      'Should emit [RestaurantLoading, RestaurantLoaded] when successful',
      build: () {
        when(() => mockSearchUseCase())
            .thenAnswer((_) async => Right(tRestaurantList));
        return restoCubit;
      },
      act: (_) => restoCubit.searchRestaurants(),
      expect: () => [
        const RestaurantLoading(),
        RestaurantLoaded(restaurants: tRestaurantList),
      ],
    );

    blocTest<RestaurantCubit, RestaurantState>(
      'Should emit [RestaurantLoading, RestaurantError] when unsuccessful',
      build: () {
        when(() => mockSearchUseCase())
            .thenAnswer((_) async => const Left(tFailure));
        return restoCubit;
      },
      act: (_) => restoCubit.searchRestaurants(),
      expect: () => [
        const RestaurantLoading(),
        RestaurantError(message: tFailure.errorMessage),
      ],
    );
  });
}
