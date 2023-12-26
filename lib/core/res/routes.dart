import 'package:dicoding_final/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dicoding_final/features/detail/presentation/pages/detail_page.dart';
import 'package:dicoding_final/features/search/presentation/pages/search_page.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = {
    DashboardPage.routeName: (_) => const DashboardPage(),
    DetailPage.routeName: (_) => const DetailPage(),
    SearchPage.routeName: (_) => const SearchPage(),
  };

  static const dashboardPage = DashboardPage.routeName;
  static const detailPage = DetailPage.routeName;
  static const searchPage = SearchPage.routeName;
}
