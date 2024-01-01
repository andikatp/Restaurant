import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';

class SaveRestaurant implements UseCaseWithParams<void, DetailRestaurant> {
  const SaveRestaurant({required DetailRepo repo})
      : _repo = repo;
  final DetailRepo _repo;

  @override
  ResultFuture<void> call(DetailRestaurant restaurant) {
    return _repo.saveRestaurant(restaurant);
  }
}
