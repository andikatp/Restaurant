import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:dicoding_final/core/services/injection_container.dart';

class Navigation {
  static void intentWithData(PageRouteInfo routeName) {
    sl<AppRouter>().push(routeName);
  }

  static void back() =>  sl<AppRouter>().pop();
}
