import 'package:dicoding_final/core/network_info/network_info.dart';
import 'package:dicoding_final/core/preferences/preferences.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:dicoding_final/features/detail/data/datasources/remote/detail_remote_data_source.dart';
import 'package:dicoding_final/features/detail/data/repositories/detail_repo_impl.dart';
import 'package:dicoding_final/features/detail/domain/repositories/detail_repo.dart';
import 'package:dicoding_final/features/detail/domain/usecases/get_detail_restaurant.dart';
import 'package:dicoding_final/features/detail/domain/usecases/review_restaurant.dart';
import 'package:dicoding_final/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/local/app_database.dart';
import 'package:dicoding_final/features/explore_restaurants/data/datasources/remote/explore_restaurants_remote_data_source.dart';
import 'package:dicoding_final/features/explore_restaurants/data/repositories/explore_restaurants_impl.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/repositories/explore_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/delete_saved_restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/get_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/get_saved_restaurants.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/save_restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/domain/usecases/search_restaurant.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:dicoding_final/features/notification/data/datasources/notification_data_source.dart';
import 'package:dicoding_final/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:dicoding_final/features/notification/domain/repositories/notification_repo.dart';
import 'package:dicoding_final/features/notification/domain/usecases/turn_notification.dart';
import 'package:dicoding_final/features/notification/presentation/provider/scheduling_provider.dart';
import 'package:dicoding_final/features/shared/saved_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final sharedPreferences = await SharedPreferences.getInstance();

  // Feature
  sl
    ..registerFactory(
      () => ExploreRestaurantsCubit(
        getRestaurantUsecase: sl(),
        searchRestaurantUsecase: sl(),
      ),
    )
    ..registerFactory(
      () => SavedProvider(
        saveRestaurant: sl(),
        getSavedRestaurants: sl(),
        deleteSavedRestaurant: sl(),
      ),
    )
    ..registerFactory(
      () => DetailCubit(
        usecase: sl(),
        addReview: sl(),
      ),
    )
    ..registerFactory(
      () => SchedulingProvider(
        turnNotification: sl(),
        preferences: sl(),
      ),
    )

    // usecases
    ..registerLazySingleton(() => GetRestaurants(repo: sl()))
    ..registerLazySingleton(() => SearchRestaurant(repo: sl()))
    ..registerLazySingleton(() => GetSavedRestaurants(repo: sl()))
    ..registerLazySingleton(() => SaveRestaurant(repo: sl()))
    ..registerLazySingleton(() => DeleteSavedRestaurant(repo: sl()))
    ..registerLazySingleton(() => GetDetailRestaurant(repo: sl()))
    ..registerLazySingleton(() => ReviewRestaurant(repo: sl()))
    ..registerLazySingleton(() => TurnNotification(repo: sl()))

    // repos
    ..registerLazySingleton<ExploreRestaurantsRepo>(
      () => ExploreRestaurantsRepoImpl(
        dataSource: sl(),
        networkInfo: sl(),
        database: sl(),
      ),
    )
    ..registerLazySingleton<DetailRepo>(
      () => DetailRepoImpl(remote: sl(), network: sl()),
    )
    ..registerLazySingleton<NotificationRepo>(
      () => NotificationRepoImpl(dataSource: sl()),
    )

    // data sources
    ..registerLazySingleton<ExploreRestaurantsRemoteDataSource>(
      () => ExploreRestaurantsRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<DetailRemoteDataSource>(
      () => DetailRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImpl(
        explore: sl<ExploreRestaurantsRemoteDataSource>(),
        sharedPreferences: sl<SharedPreferences>(),
      ),
    )

    // core
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(networkInfo: sl()),
    )
    ..registerLazySingleton<Preferences>(
      () => PreferencesImpl(sharedPreferences: sl()),
    )

    // external
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<AppDatabase>(database)
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(InternetConnection.new)
    ..registerLazySingleton(FlutterLocalNotificationsPlugin.new);
}
