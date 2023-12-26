// import 'package:dartz/dartz.dart';
// import 'package:dicoding_final/core/errors/failure.dart';
// import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
// import 'package:dicoding_final/features/restaurant/domain/repositories/restaurant_repo.dart';
// import 'package:dicoding_final/features/restaurant/domain/usecases/search_restaurant.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import 'restaurant_repo.mock.dart';

// void main() {
//   late SearchRestaurant usecase;
//   late RestaurantRepo mockRepository;

//   setUp(() {
//     mockRepository = MockRestaurantRepo();
//     usecase = SearchRestaurant(repo: mockRepository);
//   });

//   final tListRestaurants = [const Restaurant.empty(), const Restaurant.empty()];
//   const tFailure = ServerFailure(message: 'message');
//   const tSearch = '';

//   test('call [RestaurantRepo] when call [GetRestaurant] usecase', () async {
//     // arrange
//     when(() => mockRepository.searchRestaurant(any()))
//         .thenAnswer((_) async => Right(tListRestaurants));
//     // act
//     final result = await usecase(tSearch);
//     // assert
//     expect(result, equals(Right<dynamic, List<Restaurant>>(tListRestaurants)));
//     verify(() => mockRepository.searchRestaurant(tSearch)).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });

//   test('call return [CacheFailure] when [SearchRestaurant] failed', () async {
//     // arrange
//     when(() => mockRepository.searchRestaurant(any()))
//         .thenAnswer((_) async => const Left(tFailure));
//     // act
//     final result = await usecase(tSearch);
//     // assert
//     expect(result, equals(const Left<Failure, dynamic>(tFailure)));
//     verify(() => mockRepository.searchRestaurant(tSearch)).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });
// }
