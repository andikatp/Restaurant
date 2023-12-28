import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/pages/home_page.dart';
import 'package:dicoding_final/features/saved_restaurants/presentations/pages/saved_restaurants_page.dart';
import 'package:dicoding_final/features/settings/presentations/pages/settings_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final iconList = <IconData>[Icons.home, Icons.favorite, Icons.settings];
    final pages = <Widget>[
      const RestaurantPage(),
      const SavedRestaurantPage(),
      const SettingPage(),
    ];
    var bottomNavIndex = 0;

    return Scaffold(
      body: IndexedStack(
        index: bottomNavIndex,
        children: pages,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Icon(
            iconList[index],
            size: 24,
            color: isActive ? Colors.amber : Colors.blue,
          );
        },
        activeIndex: bottomNavIndex,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => bottomNavIndex = index),
      ),
    );
  }
}
