import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:dicoding_final/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dicoding_final/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:dicoding_final/features/detail/presentation/pages/detail_page.dart';
import 'package:dicoding_final/features/search/presentation/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = {
    DashboardPage.routeName: (_) => BlocProvider<DashboardCubit>(
          create: (_) => sl<DashboardCubit>(),
          child: const DashboardPage(),
        ),
    DetailPage.routeName: (_) => BlocProvider<DetailCubit>(
          create: (context) => sl<DetailCubit>(),
          child: const DetailPage(),
        ),
    SearchPage.routeName: (_) => const SearchPage(),
  };

  static const dashboardPage = DashboardPage.routeName;
  static const detailPage = DetailPage.routeName;
  static const searchPage = SearchPage.routeName;
}
