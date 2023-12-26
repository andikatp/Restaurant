import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';

class GetDetailRestaurant implements UseCaseWithParams<Restaurant, String> {
  const GetDetailRestaurant({required DetailRepo repo}) : _repo = repo;
  final DetailRepo _repo;

  @override
  ResultFuture<Restaurant> call(String id) {
    return _repo.getDetailRestaurant(id);
  }
}
