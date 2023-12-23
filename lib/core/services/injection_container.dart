import 'package:dicoding_final/features/restaurant/data/datasources/restaurant_local_data_source.dart';
import 'package:dicoding_final/features/restaurant/data/repositories/restaurant_repo_impl.dart';
import 'package:dicoding_final/features/restaurant/domain/repositories/restaurant_repo.dart';
import 'package:dicoding_final/features/restaurant/domain/usecases/get_restaurant.dart';
import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> init() async {
  final sl = GetIt.instance;
  // Feature => Restaurants
  sl
    ..registerFactory(() => RestaurantCubit(getRestaurants: sl()))
    //use cases
    ..registerLazySingleton(() => GetRestaurants(repo: sl()))
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
