import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SavedRestaurantPage extends StatelessWidget {
  const SavedRestaurantPage({super.key});

  static const routeName = '/saved';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Saved'),
    );
  }
}
