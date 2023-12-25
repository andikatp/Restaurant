import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/features/restaurant/domain/entities/restaurant.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/appbar_detail_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/detail_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final restaurant = context.modalRoute!.settings.arguments! as Restaurant;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          AppBarDetail(restaurant: restaurant),
          DetailWidget(restaurant: restaurant),
          MenuWidget(restaurant: restaurant),
        ],
      ),
    );
  }
}
