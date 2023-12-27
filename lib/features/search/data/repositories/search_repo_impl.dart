import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/search/data/datasources/search_remote_data_source.dart';
import 'package:dicoding_final/features/search/domain/repositories/search_repo.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:flutter/widgets.dart';

class SearchRepoImpl implements SearchRepo {
  SearchRepoImpl({
    required SearchRemoteDataSource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  final SearchRemoteDataSource _dataSource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<Restaurant>> searchRestaurant(String restaurantName) async {
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
}
