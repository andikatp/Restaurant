import 'package:dartz/dartz.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/errors/exception.dart';
import 'package:dicoding_final/core/errors/failure.dart';
import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/core/utils/typedef.dart';
import 'package:dicoding_final/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:dicoding_final/features/dashboard/domain/repositories/dashboard_repo.dart';
import 'package:dicoding_final/shared/models/restaurant_model.dart';

class DashboardRepoImpl implements DashboardRepo {
  const DashboardRepoImpl({
    required NetworkInfo networkInfo,
    required DashboardRemoteDataSource dataSource,
  })  : _remote = dataSource,
        _networkInfo = networkInfo;

  final DashboardRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<RestaurantModel>> getRestaurants() async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _remote.getRestaurants();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
