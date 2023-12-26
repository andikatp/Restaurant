import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/appbar_detail_widget.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/detail_widget.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/menu_widget.dart';

import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  static const routeName = '/detail';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

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
