import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/detail/data/datasources/detail_remote_data_source.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';

class DetailRepoImpl implements DetailRepo {
  DetailRepoImpl({required DetailRemoteDataSourceImpl remote})
      : _remote = remote;
  final DetailRemoteDataSource _remote;

  @override
  ResultFuture<Restaurant> getDetailRestaurant(String id) async {
    try {
      final result = await _remote.getDetailRestaurant(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
