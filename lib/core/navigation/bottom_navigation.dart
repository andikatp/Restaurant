import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/pages/restaurant_page.dart';
import 'package:dicoding_final/features/saved_restaurants/presentations/pages/saved_restaurants_page.dart';
import 'package:dicoding_final/features/settings/presentations/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});
  static const routeName = '/bottom-nav';

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colours.primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.settings)),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (_) => CupertinoPageScaffold(
                child: BlocProvider<ExploreRestaurantsCubit>(
                  create: (_) => sl<ExploreRestaurantsCubit>(),
                  child: const RestaurantPage(),
                ),
              ),
            );
          case 1:
            return CupertinoTabView(
              builder: (_) =>
                  const CupertinoPageScaffold(child: SavedRestaurantPage()),
            );
          case 2:
            return CupertinoTabView(
              builder: (_) => const CupertinoPageScaffold(child: SettingPage()),
            );
          default:
            return CupertinoTabView(
              builder: (_) =>
                  const CupertinoPageScaffold(child: SavedRestaurantPage()),
            );
        }
      },
      
    );
  }
}
