import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:dicoding_final/features/detail/data/datasources/detail_remote_data_source.dart';
import 'package:dicoding_final/features/detail/data/repositories/detail_repo_impl.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';
import 'package:dicoding_final/features/detail/domain/usecases/get_detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/usecases/review_restaurant.dart';
import 'package:dicoding_final/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/remote/explore_restaurants_remote_data_source.dart';
import 'package:dicoding_final/features/explore_restaurants/data/repositories/explore_restaurants_impl.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/get_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/search_restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Feature
  sl
    ..registerFactory(
      () => ExploreRestaurantsCubit(
        getRestaurantUsecase: sl(),
        searchRestaurantUsecase: sl(),
      ),
    )
    ..registerFactory(() => DetailCubit(usecase: sl(), addReview: sl()))
    // usecases
    ..registerLazySingleton(() => GetRestaurants(repo: sl()))
    ..registerLazySingleton(() => GetDetailRestaurant(repo: sl()))
    ..registerLazySingleton(() => ReviewRestaurant(repo: sl()))
    ..registerLazySingleton(() => SearchRestaurant(repo: sl()))
    // repos
    ..registerLazySingleton<ExploreRestaurantsRepo>(
      () => ExploreRestaurantsRepoImpl(dataSource: sl(), networkInfo: sl()),
    )
    ..registerLazySingleton<DetailRepo>(
      () => DetailRepoImpl(remote: sl(), network: sl()),
    )
    // data sources
    ..registerLazySingleton<ExploreRestaurantsRemoteDataSource>(
      () => ExploreRestaurantsRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<DetailRemoteDataSource>(
      () => DetailRemoteDataSourceImpl(client: sl()),
    )
    // core
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(networkInfo: sl()),
    )
    // external
    ..registerSingleton<AppRouter>(AppRouter()) 
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(InternetConnection.new);
}
