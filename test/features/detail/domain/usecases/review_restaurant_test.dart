import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';
import 'package:dicoding_final/features/detail/domain/usecases/review_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailRepo extends Mock implements DetailRepo {}

void main() {
  late DetailRepo mockRepo;
  late ReviewRestaurant usecase;

  setUp(() {
    mockRepo = MockDetailRepo();
    usecase = ReviewRestaurant(repo: mockRepo);
  });

  const params = ReviewParams(id: '1', review: 'message');
  const tFailure = ServerFailure(message: 'message');

  test('Should call [DetailRepo] when call [ReviewRepo] usecase', () async {
    // arrange
    when(() => mockRepo.reviewRestaurant(any(), any()))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(params);
    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
  });

  test('Should return [ServerFailure] when call [GetRestaurant] usecase failed',
      () async {
    // arrange
    when(() => mockRepo.reviewRestaurant(any(), any()))
        .thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecase(params);
    // assert
    expect(result, const Left<Failure, dynamic>(tFailure));
  });
}
