import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/domain/entities/restaurant.dart';

abstract class SearchRepo {
  const SearchRepo();
  ResultFuture<List<Restaurant>> searchRestaurant(String search);
}
