import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:dicoding_final/features/detail/presentation/pages/detail_page.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/pages/home_page.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = {
    RestaurantPage.routeName: (_) => BlocProvider<ExploreRestaurantsCubit>(
          create: (_) => sl<ExploreRestaurantsCubit>(),
          child: const RestaurantPage(),
        ),
    DetailPage.routeName: (_) => BlocProvider<DetailCubit>(
          create: (context) => sl<DetailCubit>(),
          child: const DetailPage(),
        ),
    SearchPage.routeName: (_) => BlocProvider<ExploreRestaurantsCubit>(
          create: (context) => sl<ExploreRestaurantsCubit>(),
          child: const SearchPage(),
        ),
  };

  static const restaurantPage = RestaurantPage.routeName;
  static const detailPage = DetailPage.routeName;
  static const searchPage = SearchPage.routeName;
}
