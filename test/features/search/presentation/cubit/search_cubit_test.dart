import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/search/domain/usecases/search_restaurant.dart';
import 'package:dicoding_final/features/search/presentation/cubit/search_cubit.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRestaurant extends Mock implements SearchRestaurant {}

void main() {
  late SearchRestaurant mockUsecase;
  late SearchCubit cubit;

  setUp(() {
    mockUsecase = MockSearchRestaurant();
    cubit = SearchCubit(usecase: mockUsecase);
  });

  const tRestaurantName = 'test';
  const tFailure = ServerFailure(message: 'message');
  const tRestaurants = [Restaurant.empty()];

  test('Should get [SearchInitial] as initial state', () async {
    // assert
    expect(cubit.state, const SearchInitial());
  });

  blocTest<SearchCubit, SearchState>(
    'Should emit [SearchLoading] and [SearchLoaded] '
    'when data is gotten successfully',
    build: () {
      when(() => mockUsecase(any()))
          .thenAnswer((_) async => const Right(tRestaurants));
      return cubit;
    },
    act: (cubit) => cubit.searchRestaurant(tRestaurantName),
    expect: () => [
      const SearchLoading(),
      const SearchLoaded(restaurants: tRestaurants),
    ],
  );

  blocTest<SearchCubit, SearchState>(
    'Should emit [SearchLoading] and [SearchError] '
    'when data is unsuccessfully',
    build: () {
      when(() => mockUsecase(any()))
          .thenAnswer((_) async => const Left(tFailure));
      return cubit;
    },
    act: (cubit) => cubit.searchRestaurant(tRestaurantName),
    expect: () => [
      const SearchLoading(),
      const SearchError(message: AppConstant.serverFailureMessage),
    ],
  );
}
