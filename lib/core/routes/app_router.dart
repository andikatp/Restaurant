import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/commons/pages/splash_page.dart';
import 'package:dicoding_final/features/detail/presentation/pages/detail_page.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/pages/restaurant_page.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/pages/search_page.dart';
import 'package:dicoding_final/features/saved_restaurants/presentations/pages/saved_restaurants_page.dart';
import 'package:dicoding_final/features/settings/presentations/pages/settings_page.dart';
import 'package:flutter/foundation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: AppNameRoute.home,
          initial: true,
        ),
        AutoRoute(page: RestaurantRoute.page, path: AppNameRoute.restaurant),
        AutoRoute(page: SearchRoute.page, path: AppNameRoute.search),
        AutoRoute(page: DetailRoute.page, path: AppNameRoute.detail),
        AutoRoute(page: SettingRoute.page, path: AppNameRoute.settings),
        AutoRoute(page: SavedRestaurantRoute.page, path: AppNameRoute.saved),
      ];
}

class AppNameRoute {
  AppNameRoute._();
  static const String home = '/';
  static const String restaurant = '/restaurants';
  static const String search = '/search';
  static const String detail = '/detail';
  static const String settings = '/settings';
  static const String saved = '/saved';
}
