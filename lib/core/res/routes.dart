import 'package:dicoding_final/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dicoding_final/features/restaurant/presentation/pages/detail_page.dart';
import 'package:dicoding_final/features/restaurant/presentation/pages/restaurants_page.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = {
    RestaurantPage.routeName: (_) => const RestaurantPage(),
    DashboardPage.routeName: (_) => const DashboardPage(),
    DetailPage.routeName: (_) => const DetailPage(),
  };
}
