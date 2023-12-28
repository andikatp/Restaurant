import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/remote/explore_restaurants_remote_data_source.dart';
import 'package:dicoding_final/features/explore_restaurants/data/models/restaurant_model.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:flutter/widgets.dart';

class ExploreRestaurantsRepoImpl implements ExploreRestaurantsRepo {
  ExploreRestaurantsRepoImpl({
    required ExploreRestaurantsRemoteDataSource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final ExploreRestaurantsRemoteDataSource _dataSource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<RestaurantModel>> getRestaurants() async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getRestaurants();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<RestaurantModel>> searchRestaurants(
    String restaurantName,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.searchRestaurant(restaurantName);
      return Right(result);
    } on ServerException catch (e, s) {
      debugPrintStack(stackTrace: s);
      return Left(ServerFailure.fromException(e));
    }
  }
  
  @override
  ResultFuture<void> deleteSavedRestaurant(Restaurant restaurant) {
    // TODO: implement deleteSavedRestaurant
    throw UnimplementedError();
  }
  
  @override
  ResultFuture<List<Restaurant>> getSavedRestaurants() {
    // TODO: implement getSavedRestaurants
    throw UnimplementedError();
  }
  
  @override
  ResultFuture<void> saveRestaurant(Restaurant restaurant) {
    // TODO: implement saveRestaurant
    throw UnimplementedError();
  }

}
