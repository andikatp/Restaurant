import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/restaurant/data/datasources/restaurant_local_data_source.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/repositories/restaurant_repo.dart';

class RestaurantRepoImpl implements RestaurantRepo {
  RestaurantRepoImpl({required RestaurantLocalDataSource dataSource})
      : _dataSource = dataSource;
  final RestaurantLocalDataSource _dataSource;

  @override
  ResultFuture<List<Restaurant>> getRestaurants() async {
    try {
      return Right(await _dataSource.getRestaurants());
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Restaurant>> searchRestaurant(String search) async {
    try {
      return Right(await _dataSource.searchRestaurant(search));
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
