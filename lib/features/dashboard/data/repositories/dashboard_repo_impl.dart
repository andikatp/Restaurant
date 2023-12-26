import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:dicoding_final/shared/models/restaurant_model.dart';
import 'package:dicoding_final/features/dashboard/domain/repositories/dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  const DashboardRepoImpl({required DashboardRemoteDataSource dataSource})
      : _remote = dataSource;
  final DashboardRemoteDataSource _remote;

  @override
  ResultFuture<List<RestaurantModel>> getRestaurants() async {
    try {
      final result = await _remote.getRestaurant();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
