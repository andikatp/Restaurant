import 'package:dicoding_final/core/usecase/usecase.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:dicoding_final/features/search/domain/repositories/search_repo.dart';

class SearchRestaurant implements UseCaseWithParams<List<Restaurant>, String> {
  const SearchRestaurant({required SearchRepo repo}) : _repo = repo;
  final SearchRepo _repo;

  @override
  ResultFuture<List<Restaurant>> call(String search) {
    return _repo.searchRestaurant(search);
  }
}
