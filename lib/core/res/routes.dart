import 'package:dicoding_final/features/restaurant/presentation/pages/detail_page.dart';
import 'package:dicoding_final/features/restaurant/presentation/pages/restaurants_page.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = {
    RestaurantPage.routeName: (_) => const RestaurantPage(),
    DetailPage.routeName: (_) => const DetailPage(),
  };
}
