import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';
import 'package:dicoding_final/features/detail/domain/usecases/get_detail_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailRepo extends Mock implements DetailRepo {}

void main() {
  late DetailRepo mockRepo;
  late GetDetailRestaurant usecase;

  setUp(() {
    mockRepo = MockDetailRepo();
    usecase = GetDetailRestaurant(repo: mockRepo);
  });

  const tRestaurant = DetailRestaurant.empty();
  const tFailure = ServerFailure(message: 'message');
  const tId = '1';

  test('Should call [DetailRepo] when call [GetDetailRestaurant] usecase',
      () async {
    // arrange
    when(() => mockRepo.getDetailRestaurant(any()))
        .thenAnswer((_) async => const Right(tRestaurant));
    // act
    final result = await usecase(tId);
    // assert
    expect(result, equals(const Right<dynamic, DetailRestaurant>(tRestaurant)));
  });

  test('Should return [ServerFailure] when call [GetRestaurant] usecase failed',
      () async {
    // arrange
    when(() => mockRepo.getDetailRestaurant(any()))
        .thenAnswer((_) async => const Left(tFailure));
    // act
    final result = await usecase(tId);
    // assert
    expect(result, const Left<Failure, dynamic>(tFailure));
  });
}
