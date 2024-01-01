import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/core/res/colours.dart';
import 'package:dicoding_final/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const homeItem = 'Home';
    const savedItem = 'Saved';
    const settingItem = 'Settings';
    
    return AutoTabsScaffold(
      routes: const [
        RestaurantRoute(),
        SavedRestaurantRoute(),
        SettingRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => Material(
        elevation: Sizes.p12,
        child: SalomonBottomBar(
          selectedItemColor: Colours.primaryColor,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          margin: REdgeInsets.symmetric(
            horizontal: Sizes.p32,
            vertical: Sizes.p12,
          ),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text(homeItem),
              unselectedColor: Colours.secondaryGreyColor,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite),
              title: const Text(savedItem),
              unselectedColor: Colours.secondaryGreyColor,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text(settingItem),
              unselectedColor: Colours.secondaryGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}
