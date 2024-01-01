import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';

class GetSavedRestaurants
    implements UseCaseWithoutParams<List<DetailRestaurant>, void> {
  const GetSavedRestaurants({required DetailRepo repo})
      : _repo = repo;
  final DetailRepo _repo;

  @override
  ResultFuture<List<DetailRestaurant>> call() {
    return _repo.getSavedRestaurants();
  }
}
