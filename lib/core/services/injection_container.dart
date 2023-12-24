import 'package:dicoding_final/features/restaurant/data/datasources/restaurant_local_data_source.dart';
import 'package:dicoding_final/features/restaurant/data/repositories/restaurant_repo_impl.dart';
import 'package:dicoding_final/features/restaurant/domain/repositories/restaurant_repo.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/get_restaurant.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/search_restaurant.dart';
import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Feature => Restaurants
  sl
    ..registerFactory(
      () => RestaurantCubit(getRestaurants: sl(), searchRestaurant: sl()),
    )
    //use cases
    ..registerLazySingleton(() => GetRestaurants(repo: sl()))
    ..registerLazySingleton(() => SearchRestaurant(repo: sl()))
    // repos
    ..registerLazySingleton<RestaurantRepo>(
      () => RestaurantRepoImpl(dataSource: sl()),
    )
    //data sources
    ..registerLazySingleton<RestaurantLocalDataSource>(
      RestaurantLocalDataSourceImpl.new,
    );
  // external = none
}
