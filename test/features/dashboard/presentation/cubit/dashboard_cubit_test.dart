import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/dashboard/domain/usecases/get_restaurants.dart';
import 'package:dicoding_final/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:dicoding_final/shared/models/restaurant_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRestaurant extends Mock implements GetRestaurants {}

void main() {
  late GetRestaurants mockGetRestaurants;
  late DashboardCubit dashboardCubit;

  setUp(() {
    mockGetRestaurants = MockGetRestaurant();
    dashboardCubit = DashboardCubit(usecase: mockGetRestaurants);
  });

  const tListRestaurants = <RestaurantModel>[
    RestaurantModel.empty(),
  ];

  const tFailure = ServerFailure(message: 'message');

  test('Should get [DashboardInitial] as initial state', () async {
    // assert
    expect(dashboardCubit.state, const DashboardInitial());
  });

  blocTest<DashboardCubit, DashboardState>(
    'Should emit [DashboardLoading] and [DashboardLoaded] '
    'when data is gotten successfully',
    build: () {
      when(() => mockGetRestaurants())
          .thenAnswer((_) async => const Right(tListRestaurants));
      return dashboardCubit;
    },
    act: (_) => dashboardCubit.getRestaurants(),
    expect: () => const <DashboardState>[
      DashboardLoading(),
      DashboardLoaded(restaurants: tListRestaurants),
    ],
    verify: (_) => mockGetRestaurants(),
  );

  blocTest<DashboardCubit, DashboardState>(
    'Should emit [DashboardLoading] and [DashboardError] '
    'when data is unsuccessfully',
    build: () {
      when(() => mockGetRestaurants())
          .thenAnswer((_) async => const Left(tFailure));
      return dashboardCubit;
    },
    act: (_) => dashboardCubit.getRestaurants(),
    expect: () =>  <DashboardState>[
      const DashboardLoading(),
      DashboardError(message: tFailure.errorMessage),
    ],
    verify: (_) => mockGetRestaurants(),
  );
}
