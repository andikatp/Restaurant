import 'package:dartz/dartz.dart';

import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/detail/data/datasources/detail_remote_data_source.dart';
import 'package:dicoding_final/features/detail/data/models/detail_restaurant_model.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';

class DetailRepoImpl implements DetailRepo {
  DetailRepoImpl({
    required DetailRemoteDataSource remote,
    required NetworkInfo network,
  })  : _remote = remote,
        _network = network;

  final DetailRemoteDataSource _remote;
  final NetworkInfo _network;

  @override
  ResultFuture<DetailRestaurantModel> getDetailRestaurant(String id) async {
    try {
      if (!await _network.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _remote.getDetailRestaurant(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> reviewRestaurant(String id, String review) async {
    try {
      if (!await _network.isConnected) {
        return const Left(InternetFailure());
      }
      await _remote.reviewRestaurant(id, review);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
