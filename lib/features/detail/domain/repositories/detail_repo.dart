import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/domain/entities/restaurant.dart';

abstract class DetailRepo {
  const DetailRepo();

  ResultFuture<Restaurant> getDetailRestaurant();
}
