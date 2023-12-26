import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/dashboard/domain/repositories/dashboard_repo.dart';

class GetRestaurants implements UseCaseWithoutParams<List<Restaurant>, void> {
  const GetRestaurants({required DashboardRepo repo}) : _repo = repo;
  final DashboardRepo _repo;

  @override
  ResultFuture<List<Restaurant>> call() {
    return _repo.getRestaurants();
  }
}
