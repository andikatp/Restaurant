import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:dicoding_final/features/search/domain/repositories/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  @override
  ResultFuture<List<Restaurant>> searchRestaurant(String search) {
    throw UnimplementedError();
  }
}
