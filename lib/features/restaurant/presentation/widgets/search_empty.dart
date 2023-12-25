import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchEmpty extends StatelessWidget {
  const SearchEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const lottieAsset = 'assets/data_repository/empty.json';
    const lottieText = 'Restaurant not found. \nPlease check the name!';

    return SliverList(
      delegate: SliverChildListDelegate([
        Column(
          children: [
            Lottie.asset(lottieAsset),
            Text(
              lottieText,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.labelLarge,
            ),
          ],
        ),
      ]),
    );
  }
}
