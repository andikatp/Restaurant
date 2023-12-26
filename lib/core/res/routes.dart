import 'package:dicoding_final/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dicoding_final/features/detail/presentation/pages/detail_page.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = {
    DashboardPage.routeName: (_) => const DashboardPage(),
    DetailPage.routeName: (_) => const DetailPage(),
  };
}
