import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchEmpty extends StatelessWidget {
  const SearchEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Column(
          children: [
            Lottie.asset(
              'assets/data_repository/empty.json',
            ),
            Text(
              'Restaurant not found. \nPlease check the name!',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.labelLarge,
            ),
          ],
        ),
      ]),
    );
  }
}
