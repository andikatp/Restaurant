import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/usecases/get_detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/usecases/review_restaurant.dart';
import 'package:dicoding_final/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDetail extends Mock implements GetDetailRestaurant {}

class MockReviewRestaurant extends Mock implements ReviewRestaurant {}

void main() {
  late GetDetailRestaurant mockGetDetailUsecase;
  late ReviewRestaurant mockAddReview;
  late DetailCubit cubit;

  setUp(() {
    mockGetDetailUsecase = MockGetDetail();
    mockAddReview = MockReviewRestaurant();
    cubit =
        DetailCubit(usecase: mockGetDetailUsecase, addReview: mockAddReview);
  });

  const tRestaurantName = 'restaurant';
  const tDetailRestaurant = DetailRestaurant.empty();
  const tFailure = ServerFailure(message: 'message');

  test('Should get [DetailInitial] as initial state', () async {
    // assert
    expect(cubit.state, const DetailInitial());
  });

  blocTest<DetailCubit, DetailState>(
    'Should emit [DetailLoading] and [DetailLoaded] '
    'when data is gotten successfully',
    build: () {
      when(() => mockGetDetailUsecase(tRestaurantName))
          .thenAnswer((_) async => const Right(tDetailRestaurant));
      return cubit;
    },
    act: (cubit) => cubit.getDetailRestaurant(tRestaurantName),
    expect: () => [
      const DetailLoading(),
      const DetailLoaded(restaurant: tDetailRestaurant),
    ],
  );

  blocTest<DetailCubit, DetailState>(
    'Should emit [DetailLoading] and [DetailError] '
    'when data is unsuccessfully',
    build: () {
      when(
        () => mockGetDetailUsecase(tRestaurantName),
      ).thenAnswer((_) async => const Left(tFailure));
      return cubit;
    },
    act: (cubit) => cubit.getDetailRestaurant(tRestaurantName),
    expect: () => [
      const DetailLoading(),
      const DetailError(message: AppConstant.serverFailureMessage),
    ],
  );
}
