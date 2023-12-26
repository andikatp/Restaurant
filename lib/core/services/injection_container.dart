import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:dicoding_final/features/dashboard/data/repositories/dashboard_repo_impl.dart';
import 'package:dicoding_final/features/dashboard/domain/repositories/dashboard_repo.dart';
import 'package:dicoding_final/features/dashboard/domain/usecases/get_restaurants.dart';
import 'package:dicoding_final/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Feature => Dashboard
  sl
    ..registerFactory(
      () => DashboardCubit(getRestaurants: sl()),
    )
    // usecases
    ..registerLazySingleton(() => GetRestaurants(repo: sl()))
    // repos
    ..registerLazySingleton<DashboardRepo>(
      () => DashboardRepoImpl(dataSource: sl(), networkInfo: sl()),
    )
    // data sources
    ..registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(client: sl()),
    )
    // core
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(networkInfo: sl()),
    )
    // external
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(InternetConnection.new);
}
