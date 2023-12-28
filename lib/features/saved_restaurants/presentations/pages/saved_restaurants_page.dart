import 'package:flutter/material.dart';

class SavedRestaurantPage extends StatelessWidget {
  const SavedRestaurantPage({super.key});

  static const routeName ='/saved';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Saved'),
      ),
    );
  }
}
