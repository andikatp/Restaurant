import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/domain/entities/detail_restaurant.dart';

abstract class DetailRepo {
  const DetailRepo();
  ResultFuture<DetailRestaurant> getDetailRestaurant(String id);
  ResultFuture<void> reviewRestaurant(String id, String review);
}
